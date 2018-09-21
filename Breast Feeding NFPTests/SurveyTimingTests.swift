//
//  SurveyTimingTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 9/19/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest
import AWSCognito
@testable import Breast_Feeding_NFP

class SurveyTimingTests: XCTestCase {
  
  var surveyTiming: SurveyTiming!
  
  override func setUp() {
    super.setUp()
    surveyTiming = SurveyTiming()
  }
  
  override func tearDown() {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("SurveyTaskDataSet")
    dataSet.removeObject(forKey: "WeeklyTaskDate")
    super.tearDown()
  }
  
  func testEligibleForWeeklySurvey() {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
    let date = Calendar.current.date(byAdding: Calendar.Component.day, value: -7, to: Date())!
    print(date.description)
    surveyTiming.setWeeklyDate(todaysDate: date)
    print(surveyTiming.isEligibleForWeekySurvey())
    print(surveyTiming.daysTillWeeklySurvey!)
    XCTAssertEqual(surveyTiming.isEligibleForWeekySurvey(), true)
    XCTAssertEqual(surveyTiming.daysTillWeeklySurvey, 0)
  }
  
  func testIneligibleForWeeklySurvey() {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "yyyy-MM-dd HH:mm:ss zzzz"
    let date = Calendar.current.date(byAdding: Calendar.Component.day, value: -6, to: Date())!
    print(date.description)
    surveyTiming.setWeeklyDate(todaysDate: date)
    XCTAssertEqual(surveyTiming.isEligibleForWeekySurvey(), false)
    XCTAssertEqual(surveyTiming.daysTillWeeklySurvey, 1)
  }
}
