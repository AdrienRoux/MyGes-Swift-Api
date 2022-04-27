//
//  ProjectItem.swift
//  Simple GES
//
//  Created by Adri on 05/12/2021.
//

import Foundation

struct StudentGroupItem : Codable, Hashable {
    var name : String?
    var firstname : String?
    var promotion : String?
    var option : String?
    var classe : String?
    var links : [ProfileLink]?
    var u_id : Int?
}

struct GroupItem : Codable, Hashable {
    var links : [ProfileLink]?
    var groupe_name : String?
    var date_presentation : Int64?
    var project_goup_id : Int?
    var project_id : Int?
    var subject_id : Int?
    var subject_validated : Bool?
    var teacher_comment : String?
    var teacher_intern_comment : String?
    var project_group_students : [StudentGroupItem]?
}

struct GroupLogItem : Codable, Hashable {
    var links : [ProfileLink]?
    var pgl_id : Int?
    var pgl_author : String?
    var pgl_role_user : String?
    var pgl_describe : String?
    var pgl_date : Int64?
    var pgl_type_action : String?
    var user_id : Int?
    var pgr_id : Int?
}

struct ProjectFileItem : Codable, Hashable {
    var links: [ProfileLink]?
    var pf_id: Int?
    var pf_title: String?
    var pf_file: String?
    var pf_crea_date: Int64?
    var pro_id: Int?
}

public struct ProjectItem : Codable, Hashable {
    var project_id : Int?
    var teacher_id : Int?
    var author : String?
    var name : String?
    var update_date : Int64?
    var update_user : String?
    var course_name : String?
    var discipline_id : Int?
    var groups : [GroupItem]?
    var steps : [ProjectStepItem]?
    var project_files : [ProjectFileItem]?
    var project_group_logs : [GroupLogItem]?
    var is_draft : Bool?
    var project_type_id : Int?
    var project_computing_tools : String?
    var project_date : Int64?
    var project_detail_plan : String?
    var project_hearing_presentation : String?
    var project_max_student_group : Int?
    var project_min_student_group : Int?
    var project_personnal_work : Int?
    var project_presentation_duration : Int?
    var project_ref_books : String?
    var project_teaching_goals : String?
    var project_type_group : String?
    var project_type_presentation : String?
    var project_type_presentation_details : String?
    var project_type_subject : String?
    var rc_id : Int?
    var trimester_id : Int?
    var year : Int?
    var links : [ProfileLink]?
}

extension ProjectItem {
    static func stub() -> ProjectItem{
        return ProjectItem(project_id: nil, teacher_id: nil, author: nil, name: "Project Name", update_date: nil, update_user: nil, course_name: "Exemple de cours", discipline_id: nil, groups: nil, steps: [ProjectStepItem.stub(), ProjectStepItem.stub()], project_files: nil, project_group_logs: [GroupLogItem.stub(), GroupLogItem.stub(), GroupLogItem.stub()], is_draft: nil, project_type_id: nil, project_computing_tools: nil, project_date: nil, project_detail_plan: nil, project_hearing_presentation: nil, project_max_student_group: nil, project_min_student_group: nil, project_personnal_work: nil, project_presentation_duration: nil, project_ref_books: nil, project_teaching_goals: nil, project_type_group: nil, project_type_presentation: nil, project_type_presentation_details: nil, project_type_subject: nil, rc_id: nil, trimester_id: nil, year: nil, links: nil)
    }
}

extension GroupLogItem {
    static func stub() -> GroupLogItem {
        return GroupLogItem(links: nil, pgl_id: 0, pgl_author: nil, pgl_role_user: nil, pgl_describe: "Example text for group log", pgl_date: 0, pgl_type_action: nil, user_id: nil, pgr_id: nil)
    }
}
