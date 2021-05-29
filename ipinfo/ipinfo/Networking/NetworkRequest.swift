//
//  NetworkRequest.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

enum NetworkRequest {
    case getIpInfo(input: String)
    
    // Put paths for other requests here
    var path: String {
        switch self {
            case .getIpInfo(let address): return address
        }
    }
    
    var encodedQueryParams: String? {
        switch self {
            case .getIpInfo(_): return nil
        }
    }
    
    var headers: [String: String] {
        switch self {
            case .getIpInfo(_): return [:]
        }
    }
    
    var httpMethod: String {
        switch self {
            case .getIpInfo(_): return "GET"
        }
    }
}
