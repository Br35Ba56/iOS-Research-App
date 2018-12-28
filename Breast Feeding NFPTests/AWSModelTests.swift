//
//  AWSModelTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 12/27/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest
@testable import Breast_Feeding_NFP

class AWSModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDailySurveyModel() {
      let createResults = CreateResults()
      let surveyResults = createResults.getDailyResults()
      let dailyModel = MUDailysurvey()
      dailyModel?.setValues(dailyResults: surveyResults as! DailyTaskResults)
      XCTAssertTrue(dailyModel?.clearBlueMonitor == surveyResults.results["clearBlueMonitor"])
      XCTAssertTrue(dailyModel?.date == surveyResults.results["date"])
      XCTAssertTrue(dailyModel?.menstruation == surveyResults.results["menstruation"])
      XCTAssertTrue(dailyModel?.progesterone == surveyResults.results["progesterone"])
      XCTAssertTrue(dailyModel?.numOfTimesBabyBreastFed == surveyResults.results["numOfTimesBabyBreastFed"])
      XCTAssertTrue(dailyModel?.numOfTimesBabyExpressFed == surveyResults.results["numOfTimesBabyExpressFed"])
      XCTAssertTrue(dailyModel?.numOfTimesBabyFormulaFed == surveyResults.results["numOfTimesBabyFormulaFed"])
      XCTAssertTrue(dailyModel?.userName == surveyResults.results["userName"])
      XCTAssertTrue(dailyModel?.type == surveyResults.results["type"])
    }
  
  func testWeeklySurveyModel() {
    let createResults = CreateResults()
    let surveyResults = createResults.getWeeklyResultsOne()
    let weeklyModel = MUWeeklysurvey()
    weeklyModel?.setValues(weeklyResults: surveyResults as! WeeklyTaskResults)
    XCTAssertTrue(weeklyModel?.date == surveyResults.results["date"])
    XCTAssertTrue(weeklyModel?.usedAnyContraceptives == surveyResults.results["usedAnyContraceptives"])
    XCTAssertTrue(weeklyModel?.didMenstruateThisWeek == surveyResults.results["didMenstruateThisWeek"])
    XCTAssertTrue(weeklyModel?.recentlyDiagnosed == surveyResults.results["recentlyDiagnosed"])
    XCTAssertTrue(weeklyModel?.userName == surveyResults.results["userName"])
    XCTAssertTrue(weeklyModel?.type == surveyResults.results["type"])
    XCTAssertTrue(weeklyModel?.stillBreastfeeding == surveyResults.results["stillBreastFeeding"])
    XCTAssertTrue(weeklyModel?.areYouPregnant == surveyResults.results["areYouPregnant"])
  }
  
  func testOnboardingSurveyModel() {
    let createResults = CreateResults()
    let surveyResults = createResults.getOnboardingResults()
    let onboardingModel = MUOnboardingsurvey()
    onboardingModel?.setValues(onboardingResults: surveyResults as! OnboardingTaskResults)
    XCTAssertTrue(onboardingModel?.clearBlueMonitor == surveyResults.results["clearBlueMonitor"])
    XCTAssertTrue(onboardingModel?.date == surveyResults.results["date"])
    XCTAssertTrue(onboardingModel?.momHealth == surveyResults.results["momHealth"])
    XCTAssertTrue(onboardingModel?.breastPumpInfo == surveyResults.results["breastPumpInfo"])
    XCTAssertTrue(onboardingModel?.levelOfEducation == surveyResults.results["levelOfEducation"])
    XCTAssertTrue(onboardingModel?.howManyTimesPregnant == surveyResults.results["howManyTimesPregnant"])
    XCTAssertTrue(onboardingModel?.ethnicity == surveyResults.results["ethnicity"])
    XCTAssertTrue(onboardingModel?.userName == surveyResults.results["userName"])
    XCTAssertTrue(onboardingModel?.type == surveyResults.results["type"])
    XCTAssertTrue(onboardingModel?.participantAgeInRange == surveyResults.results["participantAgeInRange"])
    XCTAssertTrue(onboardingModel?.biologicalInfant == surveyResults.results["biologicalInfant"])
    XCTAssertTrue(onboardingModel?.howLongInPastBreastFed == surveyResults.results["howLongInPastBreastFed"])
    XCTAssertTrue(onboardingModel?.biologicalSex == surveyResults.results["biologicalSex"])
    XCTAssertTrue(onboardingModel?.breastSurgery == surveyResults.results["breastSurgery"])
    XCTAssertTrue(onboardingModel?.canReadEnglish == surveyResults.results["canReadEnglish"])
    XCTAssertTrue(onboardingModel?.marriedLength == surveyResults.results["marriedLength"])
    XCTAssertTrue(onboardingModel?.babyFeedOnDemand == surveyResults.results["babyFeedOnDemand"])
    XCTAssertTrue(onboardingModel?.infantAgeInRange == surveyResults.results["infantAgeInRange"])
    XCTAssertTrue(onboardingModel?.babyBirthDate == surveyResults.results["babyBirthDate"])
    XCTAssertTrue(onboardingModel?.babyFullTerm == surveyResults.results["babyFullTerm"])
    XCTAssertTrue(onboardingModel?.howManyChildrenBreastFed == surveyResults.results["howManyChildrenBreastFed"])
  }
}
