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
    let title: String
    let name: String
    let type: String
    let values: Values?
    
    var fieldType: FormFieldType {
        if type == "TEXT" {
            return FormFieldType.textual
        } else if type == "NUMERIC" {
            return FormFieldType.numeric
        } else if type == "LIST" {
            return FormFieldType.valuable
        }
        return self.fieldType
    }
}

struct Values: Codable {
    let none, v1, v2, v3: String
}
