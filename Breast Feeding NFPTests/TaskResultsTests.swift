//
//  TaskResultsTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 11/28/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest
@testable import Breast_Feeding_NFP

class TaskResultsTests: XCTestCase {
  var dailyTaskResults: TaskResults!
    override func setUp() {
      dailyTaskResults = DailyTaskResults()
      
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   /* func testExample() {
      dailyTaskResults.results = [
        "userName" : "tonyschndr@gmail.com",
        "date" : "11/12/18",
        "surveyType": "DailySurvey",
        DailyCycleSurvey.clearBlueMonitorStepID: "0",
        DailyCycleSurvey.progesteroneQuestionStepID : "1",
        DailyCycleSurvey.experienceBleedingStepID : "0",
        DailyCycleSurvey.menstruationQuestionStepID : "-1",
        DailyCycleSurvey.numOfTimesBabyBreastFedStepID : "4",
        DailyCycleSurvey.numOfTimesBabyExpressFedStepID : "4",
        DailyCycleSurvey.numOfTimesBabyFormulaFedStepID : "5"
      ]
      let processResults = ProcessResults(taskResults : dailyTaskResults)
      processResults.saveResultsToCoreData(taskResults: dailyTaskResults)
    }*/

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
