//
//  IPAPIProtocol.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

protocol IPAPIProtocol {
    func searchIP(with term: String, completion: @escaping ResultCallback<IPSearchResultModel>)
}
