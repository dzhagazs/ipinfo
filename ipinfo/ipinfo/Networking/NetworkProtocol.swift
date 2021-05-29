//
//  NetworkProtocol.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

protocol NetworkProtocol {
    func perform(with request: NetworkRequest, completion: @escaping ResultCallback<Data?>)
}
