//
//  Extension+UIView.swift
//  Otter
//
//  Created by Rodrigo Camargo on 11/16/21.
//

import UIKit

extension UIView {
  public func enableAutolayout() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func rotate() {
    let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = NSNumber(value: 3)
    rotation.duration = 0.5
    rotation.isCumulative = false
    rotation.repeatCount = Float.greatestFiniteMagnitude
    self.layer.add(rotation, forKey: "rotationAnimation")
  }
}
