//
//  MainViewFactory.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

protocol MainViewFactoryProtocol {
    func setupMainView(with context: MainViewModelProtocol) -> MainViewModelPresenter
    func setupIPDetailsView(with context: IPDetailsViewModelProtocol) -> IPDetailsViewModelPresenter
}

class MainViewFactory: MainViewFactoryProtocol {
    
    func setupMainView(with context: MainViewModelProtocol) -> MainViewModelPresenter {
        guard let mainVC = R.storyboard.main.mainViewController() else { fatalError() }
        mainVC.viewModel = context
        return mainVC
    }
    
    func setupIPDetailsView(with context: IPDetailsViewModelProtocol) -> IPDetailsViewModelPresenter {
        guard let detailsVC = R.storyboard.main.ipDetailsViewController() else { fatalError() }
        detailsVC.viewModel = context
        return detailsVC
    }

}
