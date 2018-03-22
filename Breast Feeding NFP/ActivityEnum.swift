//
//  ActivityEnum.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation

enum Activity: Int {
  
  case dailySurvey
  case weeklySurvey
  case withdrawSurvey
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
    case .dailySurvey:
      return "Daily Survey"
    case .weeklySurvey:
      return "Weekly Survey"
    case .withdrawSurvey:
      return "Withdraw Survey"
    }
  }
  
  var subtitle: String {
    switch self {
    case .dailySurvey:
      return ""
    case .weeklySurvey:
      return ""
    case .withdrawSurvey:
      return ""
    }
  }
}
