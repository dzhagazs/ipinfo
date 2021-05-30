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
    var searchTerm: String { get }
    func viewDidLoad()
    func shouldHandleInput(text: String) -> Bool
    func handleInput(text: String) throws
    func searchAction()
}

enum MainRoute {
    case ipDetails(context: IPSearchResultModel)
}

protocol MainRouteHandler: AnyObject {
    func handle(route: MainRoute)
}
