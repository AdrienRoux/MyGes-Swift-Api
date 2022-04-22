//
//  UserDefaults.swift
//  Simple GES
//
//  Created by Adri on 15/04/2022.
//

import Foundation
extension UserDefaults {
    func saveFromJson<T : Encodable>(_ toEncode: [T]?, key: String) {
        if toEncode != nil {
            let jsonData = try? JSONEncoder().encode(toEncode)
            let json = String(data: jsonData ?? Data(), encoding: String.Encoding.utf8)
            self.set(json, forKey: key)
        }
    }
    
    func retrieveFromJson<T: Decodable>(key: String) -> [T]? {
        if self.object(forKey: key) != nil {
            return try? JSONDecoder().decode([T].self, from: self.string(forKey: key)!.data(using: .utf8)!)
        } else {
            return nil
        }
    }
}
