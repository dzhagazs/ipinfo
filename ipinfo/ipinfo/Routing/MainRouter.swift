//
//  MainRouter.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

enum MainRoute {
    case ipDetails(context: IPSearchResultModel)
}

protocol MainRouteHandler: AnyObject {
    func handle(route: MainRoute)
}

// Manages main navigation stack
class MainRouter: Router, MainRouteHandler {
    
    private weak var mainNavigation: UINavigationController?
    
    let modelFactory: MainViewModelFactoryProtocol
    let viewFactory: MainViewFactoryProtocol
    
    init(modelFactory: MainViewModelFactoryProtocol, viewFactory: MainViewFactoryProtocol) {
        self.modelFactory = modelFactory
        self.viewFactory = viewFactory
    }
    
    // MARK: Router
    
    func start(_ completion: (RootPresentable) -> Void) {
        modelFactory.routeHandler = self
        let model = modelFactory.setupMainViewModel()
        let view = viewFactory.setupMainView(with: model)
        let navigation = UINavigationController(rootViewController: view as! UIViewController)
        mainNavigation = navigation
        completion(navigation)
    }
    
    // MARK: MainRouteHandler
    
    func handle(route: MainRoute) {
        switch route {
            case .ipDetails(let context):
                let model = modelFactory.setupIPDetailsViewModel(with: context)
                let view = viewFactory.setupIPDetailsView(with: model)
                mainNavigation?.pushViewController(view as! UIViewController, animated: true)
                print(context)
        }
    }
}

extension UINavigationController: RootPresentable { }
