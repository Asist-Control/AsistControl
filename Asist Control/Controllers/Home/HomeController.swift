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
        
        trucks.forEach { truck in
            let employees = truck.employeesIds
            employees.forEach { id in
                FirebaseService.shared.getEmployee(with: id) { employee in
                    guard let employee = employee else { return }
                    truck.employees.append(employee)
                    delegate.dataLoaded()
                }
            }
        }
    }

}
