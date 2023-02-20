//
//  TruckForTodayResponse.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/20/23.
//

import Foundation

struct TruckForTodayResponse {
  let id: String
  let assistantOne: String
  let driver: String
  let assistantTwo: String
  
  init(id: String, dictionary: [String: Any]) {
    self.id = id
    self.assistantOne = dictionary["assistant_one"] as? String ?? ""
    self.driver = dictionary["driver"] as? String ?? ""
    self.assistantTwo = dictionary["assistant_two"] as? String ?? ""
  }
}
