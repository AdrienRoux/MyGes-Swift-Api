//
//  String.swift
//  MygesCalendarConverter (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

extension String {
    var toBase64 : String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func isKeyPresentInUserDefaults() -> Bool {
        return UserDefaults.standard.object(forKey: self) != nil
    }
    
    var withoutWhitespaces: String {
        return components(separatedBy: .whitespaces).joined()
    }
}
