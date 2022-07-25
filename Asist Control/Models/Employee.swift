//
//  Employee.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/8/22.
//

import Foundation

class Employee {
    
    var displayName: String {
        get {
            return "\(firstName) \(lastName)"
        }
    }
    
    var firstName: String
    var secondName: String
    var lastName: String
    var secondLastName: String
    var ci: String
    var companyBPS: BPSCompany
    var role: Role
    var birthDate: Date
    var address: String
    var phone: String
    var email: String
    var truck: String
    var civilState: String
    var numberOfKids: Int
    
    init(firstName: String, secondName: String, lastName: String, secondLastName: String, ci: String, companyBPS: BPSCompany, role: Role, birthDate: Date, address: String, phone: String, email: String, truck: String, civilState: String, numberOfKids: Int) {
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        self.secondLastName = secondLastName
        self.ci = ci
        self.companyBPS = companyBPS
        self.role = role
        self.birthDate = birthDate
        self.address = address
        self.phone = phone
        self.email = email
        self.truck = truck
        self.civilState = civilState
        self.numberOfKids = numberOfKids
    }
    
    convenience init(data: [String: Any]) {
        let firstName = data["firstName"] as? String ?? ""
        let secondName = data["secondName"] as? String ?? ""
        let lastName = data["lastName"] as? String ?? ""
        let secondLastName = data["secondLastName"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let ci = data["ci"] as? String ?? ""
        let companyBPSString = data["BPSCompany"] as? String ?? ""
        let companyBPS = BPSCompany(rawValue: companyBPSString) ?? .rustic
        //                guard let birthDateString = data["birthDate"] as? String else { return }

        let roleString = data["role"] as? String ?? ""
        let role = Role(rawValue: roleString) ?? .assistant

        let address = data["address"] as? String ?? ""
        let phone = data["phone"] as? String ?? ""
        let truckId = data["truck"] as? String ?? ""
        let civilState = data["civilState"] as? String ?? ""
        let numberOfKids = data["numberOfKids"] as? Int ?? 0
        
        self.init(firstName: firstName,
                  secondName: secondName,
                  lastName: lastName,
                  secondLastName: secondLastName,
                  ci: ci,
                  companyBPS: companyBPS,
                  role: role,
                  birthDate: Date(),
                  address: address,
                  phone: phone,
                  email: email,
                  truck: truckId,
                  civilState: civilState,
                  numberOfKids: numberOfKids)
    }
}
