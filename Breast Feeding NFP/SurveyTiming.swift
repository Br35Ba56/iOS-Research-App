//
//  SurveyTiming.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 6/27/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import AWSCognito
class SurveyTiming {
  
  var daysTillWeeklySurvey: Int!
  
  public func setWeeklyDate(date: Date) {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("SurveyTaskDataSet")
    let todaysDate = Date()
    dataSet.setString(todaysDate.description, forKey: "WeeklyTaskDate")
    dataSet.synchronize()
  }
  
  public func setDailyDate(date: Date) {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("SurveyTaskDataSet")
    let todaysDate = Date()
    dataSet.setString(todaysDate.description, forKey: "DailyTaskDate")
    dataSet.synchronize()
  }
  
  public func isEligibleForWeekySurvey() -> Bool {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("SurveyTaskDataSet")
    dataSet.synchronize()
    if let dateString = dataSet.string(forKey: "WeeklyTaskDate") {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
      let lastWeeklySurveyDate = dateFormatter.date(from: dateString)
      let todaysDate = Date()
      let diffInDays = Calendar.current.dateComponents([.day], from: lastWeeklySurveyDate!, to: todaysDate)
      if diffInDays.day! < 7 {
        daysTillWeeklySurvey = 7 - diffInDays.day!
        return false
      }
    }
    return true
  }
  
  public func isEligibleForDailySurvey() -> Bool {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("SurveyTaskDataSet")
    dataSet.synchronize()
    if let dateString = dataSet.string(forKey: "DailyTaskDate") {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
      let lastDailySurveyDate = dateFormatter.date(from: dateString)
      let todaysDate = Date()
      let diffInDays = Calendar.current.dateComponents([.day], from: lastDailySurveyDate!, to: todaysDate)
      if diffInDays.day! == 0 {
        return false
      }
    }
    return true
  }
  
  public func getDaysTillWeeklySurvey() -> Int {
    return daysTillWeeklySurvey
  }
}
