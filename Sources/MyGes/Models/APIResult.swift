//
//  APIResult.swift
//  Simple GES (iOS)
//
//  Created by Adri on 22/11/2021.
//

import Foundation

struct AgendaResult : Codable {
    var version: String?
    var links: [ProfileLink]?
    var response_code: Int?
    var result: [AgendaItem]?
}

struct ProfileResult : Codable {
    var version: String?
    var response_code: Int?
    var result: ProfileItem?
    
}

struct AbsenceResult : Codable {
    var version : String?
    var response_code : Int?
    var links : [ProfileLink]?
    var result : [AbsenceItem]?
}

struct YearsResult : Codable {
    var version : String?
    var response_code : Int?
    var links : [ProfileLink]?
    var result : [Int]?
}

struct GradesResult : Codable {
    var response_code: Int?
    var version: String?
    var result: [GradeItem]?
    var links : [ProfileLink]?
}

struct CoursesResult : Codable {
    var response_code: Int?
    var version: String?
    var result: [CourseItem]?
    var links : [ProfileLink]?
}

struct ProjectsResult : Codable {
    var response_code: Int?
    var version: String?
    var result: [ProjectItem]?
    var links : [ProfileLink]?
}

struct ProjectResult : Codable {
    var response_code: Int?
    var version: String?
    var result: ProjectItem?
    var links : [ProfileLink]?
}

struct ProjectStepsResult : Codable {
    var response_code: Int?
    var version: String?
    var result: [ProjectStepItem]?
    var links : [ProfileLink]?
}


extension AgendaResult {
    static func empty() -> AgendaResult {
        return AgendaResult(version: "", links: [], response_code: 0, result: [])
    }
}

extension ProfileResult {
    static func empty() -> ProfileResult {
        return ProfileResult(version: "", response_code: 0, result: ProfileItem.stub())
    }
}

extension AbsenceResult {
    static func empty() -> AbsenceResult {
        return AbsenceResult(version: "", response_code: 0, links: [], result: [])
    }
}

extension YearsResult {
    static func empty() -> YearsResult {
        return YearsResult(version: "", response_code: 0, links: [], result: [])
    }
}

extension GradesResult {
    static func empty() -> GradesResult {
        return GradesResult(response_code: 0, version: "", result: [], links: [])
    }
}

extension CoursesResult {
    static func empty() -> CoursesResult {
        return CoursesResult(response_code: 0, version: "", result: [], links: [])
    }
}

extension ProjectsResult {
    static func empty() -> ProjectsResult {
        return ProjectsResult(response_code: 0, version: "", result: [], links: [])
    }
}

extension ProjectResult {
    static func empty() -> ProjectResult {
        return ProjectResult(response_code: 0, version: "", result: ProjectItem.stub(), links: [])
    }
}

extension ProjectStepsResult {
    static func empty() -> ProjectStepsResult {
        return ProjectStepsResult(response_code: 0, version: "", result: [], links: [])
    }
}
