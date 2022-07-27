//
//  EmployeeController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 7/26/22.
//

import Foundation
import UIKit

protocol EmployeeControllerDelegate {
    func employeeWasAdded(_ sucess: Bool)
}

struct EmployeeController {
    
    var controller: EmployeeControllerDelegate
    
    func addEmployee(_ employee: Employee) {
        FirebaseService.shared.createEmployee(employee) { success in
            controller.employeeWasAdded(success)
        }
    }
}
