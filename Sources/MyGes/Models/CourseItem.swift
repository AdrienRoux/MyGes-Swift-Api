//
//  CourseItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

public struct CourseItem : Codable {
    public var ects: Int?
    public var coef: Int?
    public var name: String?
    public var teacher: String?
    public var trimester: String?
    public var year: Int?
    public var links: [ProfileLink]?
    public var has_documents: Bool?
    public var has_grades: Bool?
    public var nb_students: Int?
    public var rc_id: Int?
    public var school_id: Int?
    public var student_group_id: Int?
    public var student_group_name: String?
    public var syllabus_id: Int?
    public var teacher_id: Int?
    public var trimester_id: Int?
}
