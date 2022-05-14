//
//  Credentials.swift
//  Simple GES (iOS)
//
//  Created by Adri on 18/11/2021.
//

import Foundation

public struct Credentials: Codable {
    public var username: String = ""
    public var password: String = ""
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
