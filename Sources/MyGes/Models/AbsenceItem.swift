//
//  AbsenceItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 25/11/2021.
//

import Foundation

public struct AbsenceItem : Codable, Hashable {
    var date : Int64?
    var course_name : String?
    var justified : Bool?
    var trimester : Int?
    var trimester_name : String?
    var type : String?
    var year : Int?
    var links : [ProfileLink]?
}
