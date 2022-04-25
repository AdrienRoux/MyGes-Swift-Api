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
}
