//
//  AbsenceItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 25/11/2021.
//

import Foundation

public struct AbsenceItem : Codable, Hashable {
    public var date : Int64?
    public var course_name : String?
    public var justified : Bool?
    public var trimester : Int?
    public var trimester_name : String?
    public var type : String?
    public var year : Int?
    public var links : [ProfileLink]?
}
