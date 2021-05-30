//
//  IPSearchResultModel.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

enum IPModelFieldValue {
    case string(value: String)
    case number(value: Float)
    case bool(value: Bool)
    
    var stringValue: String {
        switch self {
            case .bool(let v): return "\(v)"
            case .number(let v): return "\(v)"
            case .string(let v): return v
        }
    }
}

struct IPSearchResultModel: Decodable {
    typealias IPField = (key: String, value: IPModelFieldValue)
    
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
            // Currently processing three value types described in IPModelFieldValue
            if let field = try? container.decode(String.self, forKey: key) {
                result.append((key: key.stringValue, value: .string(value: field)))
            } else if let field = try? container.decode(Bool.self, forKey: key) {
                result.append((key: key.stringValue, value: .bool(value: field)))
            } else if let field = try? container.decode(Float.self, forKey: key) {
                result.append((key: key.stringValue, value: .number(value: field)))
            }
        }
    }
    
    init(with fields: [IPField]) {
        self.fields = fields
    }
}
