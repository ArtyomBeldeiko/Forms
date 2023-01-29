//
//  Validator + TextualField.swift
//  ClvrtcTaskSeven
//
//  Created by Artyom Beldeiko on 29.01.23.
//

import Foundation

public func validateTextualField(with stringValue: String) -> Bool {
    
    let englishLowerCased = "abcdefghijklmnopqrstuvwxyz"
    let englishUpperCased = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let russianLowerCased = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя"
    let russianUpperCased = "АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ"
    let numbers = "1234567890"
    
    if (stringValue.rangeOfCharacter(from: NSCharacterSet.init(charactersIn: englishLowerCased + englishUpperCased + russianLowerCased + russianUpperCased + numbers).inverted) == nil) {
        return true
    } else {
        return false
    }
}
