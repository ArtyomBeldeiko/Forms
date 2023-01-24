//
//  Form.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 24.01.23.
//

import Foundation

struct Form: Codable {
    let title: String
    let image: String
    let fields: [Field]
}

struct Field: Codable {
    let title, name, type: String
    let values: Values?
}

struct Values: Codable {
    let none, v1, v2, v3: String
}
