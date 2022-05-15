//
//  GradeItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

public struct GradeItem : Codable, Hashable {
    public var course: String?
    public var code: String?
    public var grades : [Float]?
    public var bonus : Float?
    public var exam: Float?
    public var average: Float?
    public var trimester: Int?
    public var trimester_name: String?
    public var year: Int?
    public var rc_id: Int?
    public var ects: String?
    public var coef: String?
    public var teacher_civility: String?
    public var teacher_firstname: String?
    public var teacher_lastname: String?
    public var absences: Int?
    public var lates: Int?
    public var letter_mark: String?
    public var ccaverage: Float?
    public var links: [ProfileLink]?
    
    public static func stub() -> GradeItem {
        return GradeItem(course: "Test Course", code: "1", grades: [10.1, 13.4, 14.5, 17.1, 8.1], bonus: 0, exam: 13.4, average: 0, trimester: 22, trimester_name: "Semestre 2", year: 2022, rc_id: nil, ects: "2.0", coef: "2.0", teacher_civility: "M.", teacher_firstname: "Test", teacher_lastname: "Teacher", absences: 0, lates: 0, letter_mark: "A", ccaverage: 13.2, links: [])
    }
}
