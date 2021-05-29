//
//  IPSearchResultModel.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

struct IPSearchResultModel: Decodable {
    typealias IPField = (key: String, value: String)
    
    private struct DynamicCodingKeys: CodingKey {

        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    let fields: [IPField]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        fields = container.allKeys.reduce(into: []) { (result, key) in
            guard let field = try? container.decode(String.self, forKey: key) else { return }
            result.append((key: key.stringValue, value: field))
        }
    }
}
