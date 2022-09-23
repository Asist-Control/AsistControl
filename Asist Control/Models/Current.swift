//
//  Current.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 5/2/22.
//

import Foundation

class Current {
    
    static let shared = Current()
    
    var user: User?
    var trucks: [Truck] = []
    
    var rusticTrucks: [Truck] {
        get {
            return trucks.filter({ $0.companyBPS == .rustic })
        }
    }
    
    var sadelTrucks: [Truck] {
        get {
            return trucks.filter({ $0.companyBPS == .sadel })
        }
    }
    
    var delsaTrucks: [Truck] {
        get {
            return trucks.filter({ $0.companyBPS == .delsa })
        }
    }
    
    struct Today {
        
        var stringDate: String {
            get {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM, yyyy"
                dateFormatter.locale = Locale(identifier: "es")
                return dateFormatter.string(from: date)
            }
        }
        
        var date: String {
            get {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                dateFormatter.locale = Locale(identifier: "es")
                return dateFormatter.string(from: date)
            }
        }
        
    }
}
