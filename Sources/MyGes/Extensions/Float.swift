//
//  Float.swift
//  Simple GES
//
//  Created by Adri on 13/04/2022.
//

import Foundation

extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
