//
//  Validator + NumericField.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 29.01.23.
//

import Foundation

public func validateNumericField(with value: String) -> Bool {
    
    let numbers = "1234567890.,"
    
    if (value.rangeOfCharacter(from: NSCharacterSet.init(charactersIn: numbers).inverted) == nil) {
        if value.doubleValue < 1 || value.doubleValue > 1024 {
            return false
        }
        return true
    } else {
        return false
    }
}
