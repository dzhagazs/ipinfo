//
//  IPDetailsViewModel.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

class IPDetailsViewModel: IPDetailsViewModelProtocol {
    
    let data: IPSearchResultModel
    
    init(data: IPSearchResultModel) {
        self.data = data
    }
    
    // MARK: IPDetailsViewModelProtocol
    
    weak var presenter: IPDetailsViewModelPresenter?
    
    func viewDidLoad() {
        presenter?.show(rows: setupRowModels())
    }
    
    private func setupRowModels() -> [IPDetailsRowModel] {
        return data.fields.map({ IPDetailsRowModel(data: $0) })
    }
}
