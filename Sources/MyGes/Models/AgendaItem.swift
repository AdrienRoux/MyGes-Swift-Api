//
//  AgendaItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 18/11/2021.
//

import Foundation
import SwiftUI

public struct AgendaRoom : Codable, Hashable {
    public var room_id: Int?
    public var name: String?
    public var floor: String?
    public var campus: String?
    public var color: String?
    public var latitude: String?
    public var longitude: String?
    public var links: [String]?
}

public struct AgendaDiscipline : Codable, Hashable {
    public var coef: Int?
    public var ects: Int?
    public var name: String?
    public var teacher: String?
    public var trimester: String?
    public var year: Int?
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

public struct AgendaItem : Codable, Hashable {
    public var reservation_id: Int?
    public var rooms: [AgendaRoom]?
    public var type: String?
    public var modality: String?
    public var author: Int?
    public var create_date: Int64?
    public var start_date: Int64?
    public var end_date: Int64?
    public var state: String?
    public var comment: String?
    public var classes: [String]?
    public var name: String?
    public var discipline: AgendaDiscipline?
    public var teacher: String?
    public var promotion: String?
    public var prestation_type: Int?
    public var is_electronic_signature: Bool?
}
