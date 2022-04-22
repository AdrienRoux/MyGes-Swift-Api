//
//  CourseItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

struct CourseItem : Codable {
    var ects: Int?
    var coef: Int?
    var name: String?
    var teacher: String?
    var trimester: String?
    var year: Int?
    var links: [ProfileLink]?
    var has_documents: Bool?
    var has_grades: Bool?
    var nb_students: Int?
    var rc_id: Int?
    var school_id: Int?
    var student_group_id: Int?
    var student_group_name: String?
    var syllabus_id: Int?
    var teacher_id: Int?
    var trimester_id: Int?
}
