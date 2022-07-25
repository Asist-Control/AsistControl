//
//  User.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/1/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class User {
    
    var id: String
    var firstName: String
    var lastName: String
    var email: String
    var ci: String
    var userType: UserType

    var fullName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    init(id: String, firstName: String, lastName: String, email: String, ci: String, userType: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.ci = ci
        self.userType = userType == UserType.admin.rawValue ? .admin : .user
    }
    
    convenience init(for id: String, with data: [String: Any]) {
        let firstName = data["firstName"] as? String ?? ""
        let lastName = data["lastName"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let ci = data["ci"] as? String ?? ""
        let userType = data["userType"] as? String ?? ""
        //                let dateCreated = data["dateCreated"]
        
        self.init(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            ci: ci,
            userType: userType)
    }
}

enum UserType: String {
    case admin = "Admin"
    case user = "User"
}
