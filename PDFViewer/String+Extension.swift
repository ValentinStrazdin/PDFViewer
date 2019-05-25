//
//  String+Extension.swift
//  PDFViewer
//
//  Created by Valentin Strazdin on 25/05/2019.
//  Copyright © 2019 Valentin Strazdin. All rights reserved.
//

import Foundation

extension String {
    
    var containsInvalidFileNameChars : Bool {
        let charset = CharacterSet(charactersIn: "\\/:*?\"'<>|\n\r\0\t")
        return (self.rangeOfCharacter(from: charset) != nil)
    }
    
}

protocol OptionalString {}
extension String: OptionalString {}

extension Optional where Wrapped: OptionalString {
    // Here we check if Optional String is Nil or Empty
    var isNilOrEmpty: Bool {
        return ((self as? String) ?? "").isEmpty
    }
    
    // Here we check if Optional String is Nil, Empty or Whitespaces
    var isEmptyOrWhitespaces: Bool {
        return ((self as? String) ?? "").trimmingCharacters(in: .whitespaces).isEmpty
    }
}
