//
//  ProjectStepItem.swift
//  Simple GES
//
//  Created by Adri on 05/12/2021.
//

import Foundation

struct ProjectStepItem : Codable, Hashable {
    var course_name : String?
    var group_id : Int?
    var pro_id : Int?
    var pro_name : String?
    var psp_desc : String?
    var psp_id : Int?
    var psp_limit_date : Int64?
    var psp_number : Int?
    var psp_type : String?
    var type : String?
    var links : [ProfileLink]?
}

extension ProjectStepItem {
    static func stub() -> ProjectStepItem {
        return ProjectStepItem(course_name: nil, group_id: nil, pro_id: nil, pro_name: nil, psp_desc: nil, psp_id: nil, psp_limit_date: 000000000, psp_number: nil, psp_type: nil, type: nil, links: nil)
    }
}
