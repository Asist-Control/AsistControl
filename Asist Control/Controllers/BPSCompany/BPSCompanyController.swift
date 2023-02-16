//
//  BPSCompanyController.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/4/23.
//

import Foundation

@objc protocol BPSCompanyControllerDelegate {

}

struct BPSCompanyController {
  
  var delegate: BPSCompanyControllerDelegate
  
  func getBPSCompanies() -> [BPSCompany] {
    return BPSCompany.allCases
  }
  
  func addBPSCompany() {

  }
  
}
