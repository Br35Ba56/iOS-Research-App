//
//  ActivityEnum.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation

enum Activity: Int {
  case survey
  case breastfeedingManual
  static var allValues: [Activity] {
    var index = 0
    return Array (
      AnyIterator {
        let returnedElement = self.init(rawValue: index)
        index = index + 1
        return returnedElement
      }
    )
  }
  
  var title: String {
    switch self {
    case .survey:
      return "Daily Menstrual Cycle Events"
    case .breastfeedingManual:
      return "Breast Feeding Entry"
    }
  }
  var subtitle: String {
    switch self {
    case .survey:
      return "Description of survey"
    case .breastfeedingManual:
      return "Manual Entry"
    }
  }
}
