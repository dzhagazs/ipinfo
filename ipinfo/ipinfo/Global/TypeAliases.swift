//
//  TypeAliases.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import Foundation

typealias VoidCallback = () -> Void
typealias Callback<T> = (T) -> Void
typealias ResultCallback<T> = Callback<Result<T, Error>>

typealias JSONValue = Any
typealias JSONObject = [String: JSONValue]
