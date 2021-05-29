//
//  IPDetailsViewModelProtocol.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

struct IPDetailsRowModel {
    let data: IPSearchResultModel.IPField
}

protocol IPDetailsViewModelPresenter: AnyObject {
    var viewModel: IPDetailsViewModelProtocol? { get set }
    func show(rows: [IPDetailsRowModel])
}

protocol IPDetailsViewModelProtocol {
    var presenter: IPDetailsViewModelPresenter? { get set }
    func viewDidLoad()
}

