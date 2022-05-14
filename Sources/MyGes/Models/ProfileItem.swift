//
//  ProfileItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 23/11/2021.
//

import Foundation

struct ProfileLink : Codable, Hashable {
    public var href: String?
    public var templated: Bool?
}

struct ProfileLinks : Codable {
    public var years: ProfileLink?
    public var agenda: ProfileLink?
    public var grades: ProfileLink?
    public var classes: ProfileLink?
    public var courses: ProfileLink?
    public var teachers: ProfileLink?
    public var news: ProfileLink?
    public var photo: ProfileLink?
}

struct EmergencyContact : Codable {
    public var emergency_id: Int?
    public var type: String?
    public var type_details: String?
    public var firstname: String?
    public var name: String?
    public var telephone: String?
    public var mobile: String?
    public var work_phone: String?
}

public struct ProfileItem : Codable {
    public var uid: Int?
    public var student_id: String?
    public var ine: String?
    public var civility: String?
    public var firstname: String?
    public var name: String?
    public var maiden_name: String?
    public var birthday: Int64?
    public var birthplace: String?
    public var birth_country: String?
    public var address1: String?
    public var address2: String?
    public var city: String?
    public var zipcode: String?
    public var country: String?
    public var telephone: String?
    public var mobile: String?
    public var email: String?
    public var nationality: String?
    public var personal_mail: String?
    public var mailing: String?
    public var emergency_contact: EmergencyContact?
    public var _links: ProfileLinks?
}

extension ProfileItem {
    static func stub() -> ProfileItem {
        return ProfileItem(uid: nil, student_id: "", ine: "", civility: "", firstname: "John", name: "Appleseed", maiden_name: "", birthday: Int64(Date().millisecondsSince1970), birthplace: "Paris", birth_country: "France", address1: "242 Rue du Faubourg Saint-Antoine", address2: "", city: "Paris", zipcode: "75012", country: "France", telephone: "0123456789", mobile: "0123456789", email: "email@myges.fr", nationality: "Francais", personal_mail: "email@gmail.com", mailing: "", emergency_contact: EmergencyContact(emergency_id: nil, type: "Père", type_details: "", firstname: "John", name: "Appleseed", telephone: "0123456789", mobile: "0123456789", work_phone: "0123456789"), _links: ProfileLinks(years: nil, agenda: nil, grades: nil, classes: nil, courses: nil, teachers: nil, news: nil, photo: ProfileLink(href: "https://images.unsplash.com/photo-1599625042924-a22b68c0e39a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80", templated: nil)))
    }
}
