//
//  MainHomeController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/18/23.
//

import Foundation

struct MainHomeController {

  func getTrucksCount(completion: @escaping (Int) -> Void) {
    FirebaseService.shared.getTrucksForToday { trucks in
      completion(trucks.count)
    }
  }
}
