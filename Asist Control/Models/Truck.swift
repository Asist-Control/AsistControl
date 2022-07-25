//
//  Truck.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/8/22.
//

import Foundation

class Truck {
    
    var id: String
    var driverId: String
    var assistantsIds: [String]
    var companyBPS: BPSCompany
    var isFixed: Bool
    
    var isSelected: Bool = false
    
    var driver: Employee? {
        get {
            guard employees.count > 0 else { return nil }
            return employees[0]
        }
    }
    var assistant1: Employee? {
        get {
            guard employees.count > 0 else { return nil }
            return employees[1]
        }
    }
    var assistant2: Employee? {
        get {
            guard employees.count > 0 else { return nil }
            return employees[2]
        }
    }
    
    var employees: [Employee] = []
    
    var employeesIds: [String] {
        get {
            var employeesIds = [driverId]
            assistantsIds.forEach { employeesIds.append($0) }
            return employeesIds
        }
    }
    
    init(id: String, driver: String, assistant1: String, assistant2: String, companyBPS: BPSCompany, isFixed: Bool) {
        self.id = id
        self.driverId = driver
        self.assistantsIds = [assistant1, assistant2]
        self.companyBPS = companyBPS
        self.isFixed = isFixed
        
    }
    
    convenience init(data: [String: Any]) {
        let truckId = data["truckId"] as? String ?? ""
        let companyBPSString = data["companyBPS"] as? String ?? ""
        let driverId = data["driver"] as? String ?? ""
        let assistantsIds = data["assistants"] as? [String] ?? [""]
        let isFixed = data["isFixed"] as? Bool ?? false
        
        let companyBPS = BPSCompany(rawValue: companyBPSString) ?? .rustic
        
        self.init(
            id: truckId,
            driver: driverId,
            assistant1: assistantsIds.count == 2 ? assistantsIds[0] : "",
            assistant2: assistantsIds.count == 2 ? assistantsIds[1] : "",
            companyBPS: companyBPS,
            isFixed: isFixed)
    }
    
    func isFull() -> Bool {
        return employees.count == 3
    }

}
