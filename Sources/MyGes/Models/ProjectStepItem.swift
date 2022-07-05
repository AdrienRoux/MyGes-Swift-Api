//
//  ProjectStepItem.swift
//  Simple GES
//
//  Created by Adri on 05/12/2021.
//

import Foundation

public struct ProjectStepItem : Codable, Hashable {
    public var course_name : String?
    public var group_id : Int?
    public var pro_id : Int?
    public var pro_name : String?
    public var psp_desc : String?
    public var psp_id : Int?
    public var psp_limit_date : Int64?
    public var psp_number : Int?
    public var psp_type : String?
    public var type : String?
    public var links : [ProfileLink]?
}

public extension ProjectStepItem {
    static func stub() -> ProjectStepItem {
        return ProjectStepItem(course_name: nil, group_id: nil, pro_id: nil, pro_name: nil, psp_desc: nil, psp_id: nil, psp_limit_date: 000000000, psp_number: nil, psp_type: nil, type: nil, links: nil)
    }
}
