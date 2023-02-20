//
//  Extension+UIString.swift
//  Asist Control
//
//  Created by Rodrigo Camargo on 2/20/23.
//

import Foundation

extension String {
  func toCIFormat() -> String {
    var output = ""
    let digits = Array(self)
    for i in 0..<digits.count {
      if i == 1 || i == 4 {
        output += "."
      } else if i == 7 {
        output += "-"
      }
      output += String(digits[i])
    }
    return output
  }
}
