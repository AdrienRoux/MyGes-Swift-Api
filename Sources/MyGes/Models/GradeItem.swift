//
//  GradeItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 28/11/2021.
//

import Foundation

public struct GradeItem : Codable, Hashable {
    var course: String?
    var code: String?
    var grades : [Float]?
    var bonus : Float?
    var exam: Float?
    var average: Float?
    var trimester: Int?
    var trimester_name: String?
    var year: Int?
    var rc_id: Int?
    var ects: String?
    var coef: String?
    var teacher_civility: String?
    var teacher_firstname: String?
    var teacher_lastname: String?
    var absences: Int?
    var lates: Int?
    var letter_mark: String?
    var ccaverage: Float?
    var links: [ProfileLink]?
    
    static func stub() -> GradeItem {
        return GradeItem(course: "Test Course", code: "1", grades: [10.1, 13.4, 14.5, 17.1, 8.1], bonus: 0, exam: 13.4, average: 0, trimester: 22, trimester_name: "Semestre 2", year: 2022, rc_id: nil, ects: "2.0", coef: "2.0", teacher_civility: "M.", teacher_firstname: "Test", teacher_lastname: "Teacher", absences: 0, lates: 0, letter_mark: "A", ccaverage: 13.2, links: [])
    }
}
