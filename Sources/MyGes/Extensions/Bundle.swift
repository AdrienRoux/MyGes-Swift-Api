//
//  Bundle.swift
//  Simple GES
//
//  Created by Adri on 18/04/2022.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}

//Bundle.main.releaseVersionNumber
//Bundle.main.buildVersionNumber
