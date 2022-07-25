//
//  Extension+UIFont.swift
//  Otter
//
//  Created by Rodrigo Camargo on 11/16/21.
//

import UIKit

extension UIFont {
  static let h1: UIFont = {
    let font = UIFont.systemFont(ofSize: 32, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h1Medium: UIFont = {
    let font = UIFont.systemFont(ofSize: 32, weight: .medium)
    let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h1Light: UIFont = {
    let font = UIFont.systemFont(ofSize: 32, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h1LightAmount: UIFont = {
    let font = UIFont.systemFont(ofSize: 40, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h2: UIFont = {
    let font = UIFont.systemFont(ofSize: 24, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .title2)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h2Medium: UIFont = {
    let font = UIFont.systemFont(ofSize: 24, weight: .medium)
    let fontMetrics = UIFontMetrics(forTextStyle: .title2)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h2Light: UIFont = {
    let font = UIFont.systemFont(ofSize: 24, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .title2)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h3: UIFont = {
    let font  = UIFont.systemFont(ofSize: 17, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .headline)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h3Medium: UIFont = {
    let font  = UIFont.systemFont(ofSize: 17, weight: .medium)
    let fontMetrics = UIFontMetrics(forTextStyle: .headline)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let h3Regular: UIFont = {
    let font  = UIFont.systemFont(ofSize: 17, weight: .regular)
    let fontMetrics = UIFontMetrics(forTextStyle: .headline)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body1: UIFont = {
    let font = UIFont.systemFont(ofSize: 18, weight: .regular)
    let fontMetrics = UIFontMetrics(forTextStyle: .body)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body1Bold: UIFont = {
    let font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .body)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body1Light: UIFont = {
    let font = UIFont.systemFont(ofSize: 18, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .body)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body2: UIFont = {
    let font = UIFont.systemFont(ofSize: 16, weight: .regular)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body2Medium: UIFont = {
    let font = UIFont.systemFont(ofSize: 16, weight: .medium)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body2Bold: UIFont = {
    let font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let body2Light: UIFont = {
    let font = UIFont.systemFont(ofSize: 16, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let caption: UIFont = {
    let font = UIFont.systemFont(ofSize: 12, weight: .regular)
    let fontMetrics = UIFontMetrics(forTextStyle: .caption1)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let captionLight: UIFont = {
    let font = UIFont.systemFont(ofSize: 12, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .caption1)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let captionBold: UIFont = {
    let font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .caption1)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let buttonSmall: UIFont = {
    let font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    let fontMetrics = UIFontMetrics(forTextStyle: .footnote)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let amount: UIFont = {
    let font = UIFont.systemFont(ofSize: 20, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let amountLarge: UIFont = {
    let font = UIFont.systemFont(ofSize: 22, weight: .light)
    let fontMetrics = UIFontMetrics(forTextStyle: .title2)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let amountLargeDecimals: UIFont = {
    let font = UIFont.systemFont(ofSize: 14, weight: .medium)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
  
  static let bottomBarItem: UIFont = {
    let font = UIFont.systemFont(ofSize: 10, weight: .regular)
    let fontMetrics = UIFontMetrics(forTextStyle: .callout)
    return fontMetrics.scaledFont(for: font)
  }()
}
