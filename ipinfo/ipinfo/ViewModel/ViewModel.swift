//
//  ViewModel.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

protocol ViewModelPresenter: AnyObject {
    var viewModel: ViewModel { get set }
}

protocol ViewModel {
    func viewDidLoad()
    var presenter: ViewModelPresenter? { get set }
}
