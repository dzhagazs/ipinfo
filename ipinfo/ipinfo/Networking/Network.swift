//
//  Network.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation
import Alamofire

class Network: NetworkProtocol {
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: NetworkProtocol
    
    func perform(with request: NetworkRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        AF.request(baseURL.appendingPathComponent(request.path),
                   method: HTTPMethod(rawValue: request.httpMethod),
                   parameters: request.encodedQueryParams,
                   headers: HTTPHeaders(request.headers.map({ HTTPHeader(name: $0, value: $1) })))
            .response { responseData in
                switch responseData.result {
                    case .success(let data): completion(.success(data))
                    case .failure(let error): completion(.failure(error))
                }
            }
    }
}

class ErrorConstants {
    static let decodeFail: Error = NSError(domain: "com.test.ipinfo", code: -3, userInfo: [NSLocalizedDescriptionKey: "Response decoding failed.", NSLocalizedFailureReasonErrorKey: "Response decoding failed."])
    
    static let emptyResponse: Error = NSError(domain: "com.test.ipinfo", code: -4, userInfo: [NSLocalizedDescriptionKey: "Empty response received.", NSLocalizedFailureReasonErrorKey: "Empty response received."])
}
