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
    private var searchTerm: String = ""
    
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
    
    func handleInput(text: String) {
        searchTerm = text
        presenter?.setSearch(enabled: validator.isValid(input: text))
    }
    
    func searchAction() {
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

class IpAddressInputValidator: InputValidator {
    
    private let regex: NSRegularExpression
    private let charSet: CharacterSet
    
    init() {
        regex = try! NSRegularExpression(pattern: "^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\\.(?!$)|$)){4}$")
        charSet = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
    }
    
    // MARK: InputValidator
    
    func isValid(input: String) -> Bool {
        return regex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count))?.range == NSRange(location: 0, length: input.count)
    }
    
    func shouldHandle(input: String) -> Bool {
        return CharacterSet(charactersIn: input).isSubset(of: charSet)
    }
}
