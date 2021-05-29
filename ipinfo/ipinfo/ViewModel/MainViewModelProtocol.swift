//
//  MainViewModelProtocol.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

protocol MainViewModelPresenter: AnyObject {
    var viewModel: MainViewModelProtocol? { get set }
    func update(title: String)
    func update(subtitle: String)
    func update(searchButtonTitle: String)
    func update(searchText: String)
    func setSearch(enabled: Bool)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

protocol MainViewModelProtocol {
    var routeHandler: MainRouteHandler? { get set }
    var presenter: MainViewModelPresenter? { get set }
    func viewDidLoad()
    func shouldHandleInput(text: String) -> Bool
    func handleInput(text: String)
    func searchAction()
}

protocol InputValidator {
    func isValid(input: String) -> Bool
    func shouldHandle(input: String) -> Bool
}
