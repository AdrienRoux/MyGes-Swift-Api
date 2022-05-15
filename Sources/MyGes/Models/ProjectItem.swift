//
//  ProjectItem.swift
//  Simple GES
//
//  Created by Adri on 05/12/2021.
//

import Foundation

public struct StudentGroupItem : Codable, Hashable {
    public var name : String?
    public var firstname : String?
    public var promotion : String?
    public var option : String?
    public var classe : String?
    public var links : [ProfileLink]?
    public var u_id : Int?
}

public struct GroupItem : Codable, Hashable {
    public var links : [ProfileLink]?
    public var groupe_name : String?
    public var date_presentation : Int64?
    public var project_group_id : Int?
    public var project_id : Int?
    public var subject_id : Int?
    public var subject_validated : Bool?
    public var teacher_comment : String?
    public var teacher_intern_comment : String?
    public var project_group_students : [StudentGroupItem]?
}

public struct GroupLogItem : Codable, Hashable {
    public var links : [ProfileLink]?
    public var pgl_id : Int?
    public var pgl_author : String?
    public var pgl_role_user : String?
    public var pgl_describe : String?
    public var pgl_date : Int64?
    public var pgl_type_action : String?
    public var user_id : Int?
    public var pgr_id : Int?
}

public struct ProjectFileItem : Codable, Hashable {
    public var links: [ProfileLink]?
    public var pf_id: Int?
    public var pf_title: String?
    public var pf_file: String?
    public var pf_crea_date: Int64?
    public var pro_id: Int?
}

public struct ProjectItem : Codable, Hashable {
    public var project_id : Int?
    public var teacher_id : Int?
    public var author : String?
    public var name : String?
    public var update_date : Int64?
    public var update_user : String?
    public var course_name : String?
    public var discipline_id : Int?
    public var groups : [GroupItem]?
    public var steps : [ProjectStepItem]?
    public var project_files : [ProjectFileItem]?
    public var project_group_logs : [GroupLogItem]?
    public var is_draft : Bool?
    public var project_type_id : Int?
    public var project_computing_tools : String?
    public var project_date : Int64?
    public var project_detail_plan : String?
    public var project_hearing_presentation : String?
    public var project_max_student_group : Int?
    public var project_min_student_group : Int?
    public var project_personnal_work : Int?
    public var project_presentation_duration : Int?
    public var project_ref_books : String?
    public var project_teaching_goals : String?
    public var project_type_group : String?
    public var project_type_presentation : String?
    public var project_type_presentation_details : String?
    public var project_type_subject : String?
    public var rc_id : Int?
    public var trimester_id : Int?
    public var year : Int?
    public var links : [ProfileLink]?
}

public extension ProjectItem {
    public static func stub() -> ProjectItem{
        return ProjectItem(project_id: nil, teacher_id: nil, author: nil, name: "Project Name", update_date: nil, update_user: nil, course_name: "Exemple de cours", discipline_id: nil, groups: nil, steps: [ProjectStepItem.stub(), ProjectStepItem.stub()], project_files: nil, project_group_logs: [GroupLogItem.stub(), GroupLogItem.stub(), GroupLogItem.stub()], is_draft: nil, project_type_id: nil, project_computing_tools: nil, project_date: nil, project_detail_plan: nil, project_hearing_presentation: nil, project_max_student_group: nil, project_min_student_group: nil, project_personnal_work: nil, project_presentation_duration: nil, project_ref_books: nil, project_teaching_goals: nil, project_type_group: nil, project_type_presentation: nil, project_type_presentation_details: nil, project_type_subject: nil, rc_id: nil, trimester_id: nil, year: nil, links: nil)
    }
}

public extension GroupLogItem {
    public static func stub() -> GroupLogItem {
        return GroupLogItem(links: nil, pgl_id: 0, pgl_author: nil, pgl_role_user: nil, pgl_describe: "Example text for group log", pgl_date: 0, pgl_type_action: nil, user_id: nil, pgr_id: nil)
    }
}
