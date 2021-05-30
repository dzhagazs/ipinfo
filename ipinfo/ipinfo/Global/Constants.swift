//
//  Constants.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

let ipApiURLString = "http://ip-api.com/json/"

class ErrorConstants {
    static let decodeFail: Error = NSError(domain: "com.test.ipinfo", code: -3, userInfo: [NSLocalizedDescriptionKey: "Response decoding failed.", NSLocalizedFailureReasonErrorKey: "Response decoding failed."])
    
    static let emptyResponse: Error = NSError(domain: "com.test.ipinfo", code: -4, userInfo: [NSLocalizedDescriptionKey: "Empty response received.", NSLocalizedFailureReasonErrorKey: "Empty response received."])
    
    static let invalidInput: Error = NSError(domain: "com.test.ipinfo", code: -4, userInfo: [NSLocalizedDescriptionKey: "Invalid value typed.", NSLocalizedFailureReasonErrorKey: "Invalid value typed."])
}
