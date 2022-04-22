//
//  Data+Decode.swift
//  MygesCalendarConverter (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

enum JsonError : Error {
    case dataInvalid
}

extension Data {
    func decodeAsClass<T: Decodable>(_ debug: Bool = false) -> T? {
        do {
            
            if self.isValidJson {
                if (debug) {
                    _ = try JSONSerialization.jsonObject(with: self, options: []) as! [String: Any]
                }
                let parsedResult = try JSONDecoder().decode(T.self, from: self)
                return parsedResult
            } else {
                throw JsonError.dataInvalid
            }
        } catch let error {
            print("error decodeAsClass : \(error)")
            return nil
        }
    }
    
    var isValidJson : Bool {
        do{
            if let _ = try JSONSerialization.jsonObject(with: self, options: []) as? NSDictionary {
                return true
            } else if let _ = try JSONSerialization.jsonObject(with: self, options: []) as? NSArray {
                return true
            } else {
                return false
            }
        }
        catch _ as NSError {
            print("error isValidJson")
            return false
        }
        
    }
}
