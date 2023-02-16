//
//  TruckController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 9/19/22.
//

import Foundation

protocol TruckControllerDelegate {
  func truckWasAdded()
}

struct TruckController {

  private var delegate: TruckControllerDelegate?

  mutating func attachController(_ delegate: TruckControllerDelegate) {
    self.delegate = delegate
  }

  func uploadTruck(truck: Truck) {
    FirebaseService.shared.uploadSingleTruck(truck) { success in
      if success {
        updateTruckIDOnEmployees(for: truck)
        delegate?.truckWasAdded()
      }
    }
  }
  
  func uploadSelectedTrucks(trucks: [Truck], completion: (Bool) -> Void) {
    if canUploadTrucks(trucks) {
      uploadTrucks(trucks)
      completion(true)
    } else {
      completion(false)
    }
  }

  private func canUploadTrucks(_ trucks: [Truck]) -> Bool {
    var index = 0
    while index < trucks.count - 1 {
      let truck = trucks[index]
      if !truck.isFull() { return false }
      index += 1
    }
    return true
  }

  private func uploadTrucks(_ trucks: [Truck]) {
    FirebaseService.shared.uploadTrucksForToday(trucks)
  }

  private func updateTruckIDOnEmployees(for truck: Truck) {
    truck.employeesIds.forEach { employeeID in
      let employee = Current.shared.employees.first { $0.ci == employeeID }
      employee?.truck = truck.id
    }
    FirebaseService.shared.updateEmployees(truck.employeesIds)
  }
}
