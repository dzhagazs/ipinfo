//
//  FlowManager.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

// Represents UI presentable object
protocol RootPresentable: AnyObject { }

protocol RootPresenter {
    func present(_ presentable: RootPresentable)
}

protocol Router {
    func start(_ completion: Callback<RootPresentable>)
}

class FlowManager {
    
    private let rootPresenter: RootPresenter
    
    private var mainRouter: Router
    
    init(with presenter: RootPresenter,
         mainRouter: Router) {
        self.rootPresenter = presenter
        self.mainRouter = mainRouter
    }
    
    func setupMainFlow() {
        mainRouter.start { [weak self] vc in
            self?.rootPresenter.present(vc)
        }
    }
}

