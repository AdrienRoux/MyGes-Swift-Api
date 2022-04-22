//
//  Int64+ToDate.swift
//  MygesCalendarConverter (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

extension Int64 {
    var milisToDate : Date {
        return Date(timeIntervalSince1970: (Double(self) / 1000))
    }
}
