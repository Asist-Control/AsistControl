//
//  EmployeeController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 7/26/22.
//

import Foundation
import UIKit

@objc protocol EmployeeControllerDelegate {
  @objc optional func employeeWasAdded(_ sucess: Bool)
  @objc optional func reloadEmployees(_ employees: [Any])
}

struct EmployeeController {
    
  var delegate: EmployeeControllerDelegate
  
  func addEmployee(_ employee: Employee) {
    FirebaseService.shared.createEmployee(employee) { success in
      delegate.employeeWasAdded?(success)
    }
  }

  func loadEmployees() {
    FirebaseService.shared.getEmployees { employees in
      delegate.reloadEmployees?(employees.sorted(by: { $0.firstName < $1.firstName }))
    }
  }

  func deleteEmployee(_ employee: Employee, completion: @escaping (Bool) -> Void) {
    FirebaseService.shared.removeEmployee(employee) { success in
      completion(success)
    }
  }
  
}
