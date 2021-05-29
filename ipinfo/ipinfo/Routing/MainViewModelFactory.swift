//
//  MainViewModelFactory.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

protocol MainViewModelFactoryProtocol: AnyObject {
    var routeHandler: MainRouteHandler? { get set }
    func setupMainViewModel() -> MainViewModelProtocol
    func setupIPDetailsViewModel(with context: IPSearchResultModel) -> IPDetailsViewModelProtocol
}

class MainViewModelFactory: MainViewModelFactoryProtocol {
    
    weak var routeHandler: MainRouteHandler?
    
    // MARK: MainViewModelFactoryProtocol
    
    func setupMainViewModel() -> MainViewModelProtocol {
        return MainViewModel(ipApi: IPAPI(network: Network(baseURL: URL(string: ipApiURLString)!)), routeHandler: routeHandler)
    }
    
    func setupIPDetailsViewModel(with context: IPSearchResultModel) -> IPDetailsViewModelProtocol {
        return IPDetailsViewModel(data: context)
    }
}
