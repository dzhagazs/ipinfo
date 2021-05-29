//
//  IPAPI.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

class IPAPI: IPAPIProtocol {
    
    let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    // MARK: IPAPIProtocol
    func searchIP(with term: String, completion: @escaping (Result<IPSearchResultModel, Error>) -> Void) {
        network.perform(with: .getIpInfo(input: term)) { result in
            switch result {
                case .success(let data):
                    guard let data = data else { completion (.failure(ErrorConstants.emptyResponse)); return }
                    let decoder = JSONDecoder()
                    do {
                        let searchResult = try decoder.decode(IPSearchResultModel.self, from: data)
                        completion(.success(searchResult))
                    } catch {
                        completion(.failure(ErrorConstants.decodeFail))
                    }
                    print(data)
                case .failure(let error):
                    completion(.failure(error))
                    print(error)
            }
        }
    }
    
}
