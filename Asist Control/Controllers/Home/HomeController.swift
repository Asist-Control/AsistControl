//
//  InitialController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/13/22.
//

import Foundation

protocol HomeControllerDelegate {
  func dataLoaded()
}

struct HomeController {
  
  var delegate: HomeControllerDelegate
  
  func getAllTrucksAndLoadThemIntoApp() {
    FirebaseService.shared.getTrucks { trucks in
      guard let trucks = trucks else {
        print("There was an error loading the trucks")
        return
      }
      Current.shared.trucks = trucks
      getEmployeesForEachTruck()
    }
  }
  
  func getEmployeesForEachTruck() {
    let trucks = Current.shared.trucks

    FirebaseService.shared.getEmployees { employees in
      trucks.forEach { truck in
        let truckEmployees = truck.employeesIds
        truckEmployees.forEach { truckEmployee in
          employees.forEach { employee in
            if truckEmployee == employee.ci {
              truck.employees.append(employee)
              delegate.dataLoaded()
            }
          }
        }
      }
    }
  }
  
}
