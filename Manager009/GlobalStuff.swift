//
//  GlobalStuff.swift
//  Manager009
//
//  Created by bernard milman on 1/5/26.
//

import Foundation



func encodeToJSONString<T: Encodable>(_ value: T, using encoder: JSONEncoder = JSONEncoder()) throws -> String {
    let data = try encoder.encode(value)
    guard let json = String(data: data, encoding: .utf8) else {
        throw EncodingError.invalidValue(value, .init(codingPath: [], debugDescription: "Failed to create UTF-8 string from encoded JSON data."))
    }
    return json
}
