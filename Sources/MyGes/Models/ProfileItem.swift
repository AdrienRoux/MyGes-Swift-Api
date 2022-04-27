//
//  ProfileItem.swift
//  Simple GES (iOS)
//
//  Created by Adri on 23/11/2021.
//

import Foundation

struct ProfileLink : Codable, Hashable {
    var href: String?
    var templated: Bool?
}

struct ProfileLinks : Codable {
    var years: ProfileLink?
    var agenda: ProfileLink?
    var grades: ProfileLink?
    var classes: ProfileLink?
    var courses: ProfileLink?
    var teachers: ProfileLink?
    var news: ProfileLink?
    var photo: ProfileLink?
}

struct EmergencyContact : Codable {
    var emergency_id: Int?
    var type: String?
    var type_details: String?
    var firstname: String?
    var name: String?
    var telephone: String?
    var mobile: String?
    var work_phone: String?
}

public struct ProfileItem : Codable {
    var uid: Int?
    var student_id: String?
    var ine: String?
    var civility: String?
    var firstname: String?
    var name: String?
    var maiden_name: String?
    var birthday: Int64?
    var birthplace: String?
    var birth_country: String?
    var address1: String?
    var address2: String?
    var city: String?
    var zipcode: String?
    var country: String?
    var telephone: String?
    var mobile: String?
    var email: String?
    var nationality: String?
    var personal_mail: String?
    var mailing: String?
    var emergency_contact: EmergencyContact?
    var _links: ProfileLinks?
}

extension ProfileItem {
    static func stub() -> ProfileItem {
        return ProfileItem(uid: nil, student_id: "", ine: "", civility: "", firstname: "John", name: "Appleseed", maiden_name: "", birthday: Int64(Date().millisecondsSince1970), birthplace: "Paris", birth_country: "France", address1: "242 Rue du Faubourg Saint-Antoine", address2: "", city: "Paris", zipcode: "75012", country: "France", telephone: "0123456789", mobile: "0123456789", email: "email@myges.fr", nationality: "Francais", personal_mail: "email@gmail.com", mailing: "", emergency_contact: EmergencyContact(emergency_id: nil, type: "Père", type_details: "", firstname: "John", name: "Appleseed", telephone: "0123456789", mobile: "0123456789", work_phone: "0123456789"), _links: ProfileLinks(years: nil, agenda: nil, grades: nil, classes: nil, courses: nil, teachers: nil, news: nil, photo: ProfileLink(href: "https://images.unsplash.com/photo-1599625042924-a22b68c0e39a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80", templated: nil)))
    }
}
