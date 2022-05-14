//
//  APIResult.swift
//  Simple GES (iOS)
//
//  Created by Adri on 22/11/2021.
//

import Foundation

struct AgendaResult : Codable {
    public var version: String?
    public var links: [ProfileLink]?
    public var response_code: Int?
    public var result: [AgendaItem]?
}

struct ProfileResult : Codable {
    public var version: String?
    public var response_code: Int?
    public var result: ProfileItem?
    
}

struct AbsenceResult : Codable {
    public var version : String?
    public var response_code : Int?
    public var links : [ProfileLink]?
    public var result : [AbsenceItem]?
}

struct YearsResult : Codable {
    public var version : String?
    public var response_code : Int?
    public var links : [ProfileLink]?
    public var result : [Int]?
}

struct GradesResult : Codable {
    public var response_code: Int?
    public var version: String?
    public var result: [GradeItem]?
    public var links : [ProfileLink]?
}

struct CoursesResult : Codable {
    public var response_code: Int?
    public var version: String?
    public var result: [CourseItem]?
    public var links : [ProfileLink]?
}

struct ProjectsResult : Codable {
    public var response_code: Int?
    public var version: String?
    public var result: [ProjectItem]?
    public var links : [ProfileLink]?
}

struct ProjectResult : Codable {
    public var response_code: Int?
    public var version: String?
    public var result: ProjectItem?
    public var links : [ProfileLink]?
}

struct ProjectStepsResult : Codable {
    public var response_code: Int?
    public var version: String?
    public var result: [ProjectStepItem]?
    public var links : [ProfileLink]?
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
