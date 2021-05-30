//
//  InputValidator.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 30.05.2021.
//

import Foundation

protocol InputValidator {
    func isValid(input: String) -> Bool
    func shouldHandle(input: String) -> Bool
}

class IpAddressInputValidator: InputValidator {
    
    private let regex: NSRegularExpression
    private let charSet: CharacterSet
    
    init() {
        regex = try! NSRegularExpression(pattern: "^((25[0-5]|(2[0-4]|1[0-9]|[1-9]|)[0-9])(\\.(?!$)|$)){4}$")
        charSet = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
    }
    
    // MARK: InputValidator
    
    func isValid(input: String) -> Bool {
        return regex.firstMatch(in: input, options: [], range: NSRange(location: 0, length: input.count))?.range == NSRange(location: 0, length: input.count)
    }
    
    func shouldHandle(input: String) -> Bool {
        return CharacterSet(charactersIn: input).isSubset(of: charSet)
    }
}
