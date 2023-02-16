//
//  FirebaseService+Employee.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 7/26/22.
//

import Foundation

extension FirebaseService {
  
  // MARK: - Get
  func getEmployees(completion: @escaping ([Employee]) -> Void) {
    let docRef = firestore.collection("Employee")
    var employees = [Employee]()
    docRef.getDocuments() { querySnapshot, err in
      if let documents = querySnapshot?.documents, !documents.isEmpty {
        documents.forEach { document in
          let data = document.data()
          let employee = Employee(data: data)
          employees.append(employee)
        }
        Current.shared.employees = employees
        completion(employees)
      } else {
        print("There was a problem getting the documents for Employees")
      }
    }
  }
  
  func getEmployee(with id: String, completion: @escaping (Employee?) -> Void) {
    let docRef = firestore.collection(K.Firebase.employee).document(id)
    
    docRef.getDocument { document, error in
      if let document = document, document.exists {
        guard let data = document.data() else { return }
        
        let employee = Employee(data: data)
        completion(employee)
      } else {
        print("There was a problem getting the document for employee id: \(id)")
        completion(nil)
      }
    }
  }
  
  // MARK: - Create
  func createEmployee(_ employee: Employee, completion: ((Bool) -> Void)? = nil) {
    firestore.collection(K.Firebase.employee).document(employee.ci).setData([
      "firstName": employee.firstName,
      "secondName": employee.secondName,
      "lastName": employee.lastName,
      "secondLastName": employee.secondLastName,
      "email": employee.email,
      "ci": employee.ci,
      "address": employee.address,
      "phone": employee.phone,
      "birthDate": employee.birthDate,
      "civilState": employee.civilState,
      "BPSCompany": employee.companyBPS.rawValue,
      "role": employee.role.rawValue,
      "truck": employee.truck,
      "numberOfKids": employee.numberOfKids
    ]) { error in
      if let err = error {
        print("Error writing document: \(err)")
        completion?(false)
      } else {
        completion?(true)
      }
    }
  }

  // MARK: - Update
  func updateEmployees(_ employees: [String]) {
    employees.forEach { ci in
      let employee = Current.shared.employees.first { $0.ci == ci }
      guard let employee else { return }
      createEmployee(employee)
    }
  }
  
}
