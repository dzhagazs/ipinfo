//
//  MainViewModel.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

class MainViewModel: MainViewModelProtocol {
    
    weak var routeHandler: MainRouteHandler?
    private var validator: InputValidator
    private var ipApi: IPAPIProtocol
    
    private var title: String = "API Demo"
    private var subtitle: String = "Search any IP address"
    private var searchButtonTitle: String = "Search"
    private(set) var searchTerm: String = ""
    
    init(validator: InputValidator = IpAddressInputValidator(), ipApi: IPAPIProtocol, routeHandler: MainRouteHandler?) {
        self.validator = validator
        self.ipApi = ipApi
        self.routeHandler = routeHandler
    }

    // MARK: MainViewModelProtocol
    
    weak var presenter: MainViewModelPresenter?
    
    func viewDidLoad() {
        presenter?.update(title: title)
        presenter?.update(subtitle: subtitle)
        presenter?.update(searchButtonTitle: searchButtonTitle)
        presenter?.setSearch(enabled: false)
    }
    
    func shouldHandleInput(text: String) -> Bool {
        return validator.shouldHandle(input: text)
    }
    
    func handleInput(text: String) throws {
        if validator.shouldHandle(input: text) == false {
            throw ErrorConstants.invalidInput
        }
        searchTerm = text
        presenter?.setSearch(enabled: validator.isValid(input: text))
    }
    
    func searchAction() {
        guard validator.isValid(input: searchTerm) else { return }
        presenter?.showLoadingIndicator()
        ipApi.searchIP(with: searchTerm) { [weak self] result in
            self?.handle(searchResult: result)
        }
    }
    
    private func handle(searchResult: Result<IPSearchResultModel, Error>) {
        presenter?.hideLoadingIndicator()
        switch searchResult {
            case .success(let model):
                routeHandler?.handle(route: .ipDetails(context: model))
            case .failure(let error):
                print(error)
        }
    }
}
