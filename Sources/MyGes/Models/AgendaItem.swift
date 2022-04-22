//
//  AgendaItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 18/11/2021.
//

import Foundation
import SwiftUI

struct AgendaRoom : Codable, Hashable {
    var room_id: Int?
    var name: String?
    var floor: String?
    var campus: String?
    var color: String?
    var latitude: String?
    var longitude: String?
    var links: [String]?
}

struct AgendaDiscipline : Codable, Hashable {
    var coef: Int?
    var ects: Int?
    var name: String?
    var teacher: String?
    var trimester: String?
    var year: Int?
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

struct AgendaItem : Codable, Hashable {
    var reservation_id: Int?
    var rooms: [AgendaRoom]?
    var type: String?
    var modality: String?
    var author: Int?
    var create_date: Int64?
    var start_date: Int64?
    var end_date: Int64?
    var state: String?
    var comment: String?
    var classes: [String]?
    var name: String?
    var discipline: AgendaDiscipline?
    var teacher: String?
    var promotion: String?
    var prestation_type: Int?
    var is_electronic_signature: Bool?
}
