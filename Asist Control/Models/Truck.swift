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
  
  var driver: Employee?

  var assistant1: Employee? {
    get {
//      guard !assistants.isEmpty else { return nil }
//      return assistants[0]
      guard !assistantsIds.isEmpty else { return nil }
      return Current.shared.employees.first(where: { $0.ci == assistantsIds.first })
    }
  }
  var assistant2: Employee? {
    get {
//      guard !assistants.isEmpty else { return nil }
//      return assistants[1]
      guard assistantsIds.count > 0 else { return nil }
      return Current.shared.employees.first(where: { $0.ci == assistantsIds.last })
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
    let truckId = data["truck_id"] as? String ?? ""
    let companyBPSString = data["companyBPS"] as? String ?? ""
    let driverId = data["driver_ci"] as? String ?? ""
    let assistants1 = data["assistant1_ci"] as? String ?? ""
    let assistants2 = data["assistant2_ci"] as? String ?? ""
    let isFixed = data["isFixed"] as? Bool ?? false
    
    let companyBPS = BPSCompany(rawValue: companyBPSString) ?? .rustic
    
    self.init(
      id: truckId,
      driver: driverId,
      assistant1: assistants1,
      assistant2: assistants2,
      companyBPS: companyBPS,
      isFixed: isFixed)
  }

  func isFull() -> Bool {
    return employees.count == 3
  }

  func updateTruck(driver: Employee? = nil, helperOne: Employee? = nil, helperTwo: Employee? = nil) {
    if let driver = driver {
      self.driver = driver
    }
    if let helperOne = helperOne {
      self.assistantsIds.insert(helperOne.ci, at: 0)
    }
    if let helperTwo = helperTwo {
      self.self.assistantsIds.insert(helperTwo.ci, at: 1)
    }
  }

}
