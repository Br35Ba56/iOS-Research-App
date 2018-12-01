//
//  Breast_Feeding_NFPTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import XCTest
import AWSCore
import ResearchKit
import SwiftKeychainWrapper

@testable import Breast_Feeding_NFP

class TaskViewControllerResultsTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func testWeeklySurveyResultsOne() {
    let createResults = CreateResults()
    let surveyResults = createResults.getWeeklyResultsOne()
    
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.areYouPregnantStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.usedAnyContraceptivesStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.recentlyDiagnosedStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.stillBreastfeedingStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.didMenstruateThisWeekStepID], "0")
    XCTAssertEqual(surveyResults.results["type"], "WeeklySurvey")
  }
  
  func testWeeklySurveyResultsTwo() {
    let createResults = CreateResults()
    let surveyResults = createResults.getWeeklyResultsTwo()
    
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.areYouPregnantStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.usedAnyContraceptivesStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.recentlyDiagnosedStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.stillBreastfeedingStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklyEligibilitySurvey.didMenstruateThisWeekStepID], "1")
    XCTAssertEqual(surveyResults.results["type"], "WeeklySurvey")
  }
  
  func testDailySurveyOne() {
    
    let createResults = CreateResults()
    let surveyResults = createResults.getDailyResults()
    
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.clearBlueMonitorStepID], "0")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.progesteroneQuestionStepID], "0")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.experienceBleedingStepID], "1")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.menstruationQuestionStepID], "1")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyBreastFedStepID], "4")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyExpressFedStepID], "3")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyFormulaFedStepID], "6")
    XCTAssertEqual(surveyResults.results["type"], "DailySurvey")
  }
  
  func testOnboardingSurvey() {
    
    let createResults = CreateResults()
    let surveyResults = createResults.getOnboardingResults()
    
    XCTAssertEqual(surveyResults.results[EligibilitySteps.biologicalSexStepID], "0")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.biologicalInfantStepID], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.singletonBirthStepID], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.babyBornFullTermStep], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.participantAgeInRangeStepID], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.momHealthStepID], "0")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.breastSurgeryStepID], "0")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.infantAgeInRangeStepID], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.clearBlueMonitorStepID], "1")
    XCTAssertEqual(surveyResults.results[EligibilitySteps.canReadEnglishStepID], "1")
    XCTAssertEqual(surveyResults.results[DemographicSteps.participantBirthDateStepID], "1992-07-13")
    XCTAssertEqual(surveyResults.results[DemographicSteps.babysBirthDateStepID], "2018-08-12")
    XCTAssertEqual(surveyResults.results[DemographicSteps.babyFeedOnDemandStepID], "0")
    XCTAssertEqual(surveyResults.results[DemographicSteps.breastPumpInfoStepID], "Some Pump")
    XCTAssertEqual(surveyResults.results[DemographicSteps.ethnicityStepID], "4")
    XCTAssertEqual(surveyResults.results[DemographicSteps.religionStepID], "4")
    XCTAssertEqual(surveyResults.results[DemographicSteps.levelOfEducationStepID], "2")
    XCTAssertEqual(surveyResults.results[DemographicSteps.relationshipStatusID], "0")
    XCTAssertEqual(surveyResults.results[DemographicSteps.howManyTimesPregnantStepID], "2")
    XCTAssertEqual(surveyResults.results[DemographicSteps.howManyBiologicalChildrenStepID], "1")
    XCTAssertEqual(surveyResults.results[DemographicSteps.howManyChildrenBreastFedStepID], "1")
    XCTAssertEqual(surveyResults.results[DemographicSteps.howLongInPastBreastFedStepID], "-1")
  }
  
}
