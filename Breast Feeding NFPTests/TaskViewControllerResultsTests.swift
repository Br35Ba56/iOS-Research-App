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
  var results: [ORKStepResult] = [ORKStepResult]()
  
  
  override func setUp() {
    super.setUp()
  }
  
  override func tearDown() {
    super.tearDown()
    results.removeAll()
    
  }
  
  func testWeeklySurveyResultsOne() {
    /*Build Results */
    let areYouPregnentBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.areYouPregnantStepID)
    areYouPregnentBooleanResult.booleanAnswer = 1
    let areYouPregnantStepResult =  ORKStepResult.init(stepIdentifier: WeeklySurvey.areYouPregnantStepID, results: [areYouPregnentBooleanResult])
    
    let usedAnyContraceptivesBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.usedAnyContraceptivesStepID)
    usedAnyContraceptivesBooleanResult.booleanAnswer = 0
    let usedAnyContaceptivesStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.usedAnyContraceptivesStepID, results: [usedAnyContraceptivesBooleanResult])
    
    let recentlyDiagnosedBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.recentlyDiagnosedStepID)
    recentlyDiagnosedBooleanResult.booleanAnswer = 0
    let recentlyDiagnosedStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.recentlyDiagnosedStepID, results: [recentlyDiagnosedBooleanResult])
    
    let stillBreastFeedingBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.stillBreastfeedingStepID)
    stillBreastFeedingBooleanResult.booleanAnswer = 1
    let stillBreastfeedingStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.stillBreastfeedingStepID, results: [stillBreastFeedingBooleanResult])
    
    let didMenstruateBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.didMenstruateThisWeekStepID)
    didMenstruateBooleanResult.booleanAnswer = 0
    let didMenstruateStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.didMenstruateThisWeekStepID, results: [didMenstruateBooleanResult])
    
    
    results.append(areYouPregnantStepResult)
    results.append(usedAnyContaceptivesStepResult)
    results.append(recentlyDiagnosedStepResult)
    results.append(stillBreastfeedingStepResult)
    results.append(didMenstruateStepResult)
    
    let surveyResults =  TaskViewControllerResults.getViewControllerResults(taskViewControllerResults: results, taskID: WeeklySurvey.taskID)
    
    XCTAssertEqual(surveyResults.results[WeeklySurvey.areYouPregnantStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.usedAnyContraceptivesStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.recentlyDiagnosedStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.stillBreastfeedingStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.didMenstruateThisWeekStepID], "0")
    XCTAssertEqual(surveyResults.results["surveyType"], "WeeklySurvey")
  }
  
  func testWeeklySurveyResultsTwo() {
    let areYouPregnentBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.areYouPregnantStepID)
    areYouPregnentBooleanResult.booleanAnswer = 0
    let areYouPregnantStepResult =  ORKStepResult.init(stepIdentifier: WeeklySurvey.areYouPregnantStepID, results: [areYouPregnentBooleanResult])
    
    let usedAnyContraceptivesBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.usedAnyContraceptivesStepID)
    usedAnyContraceptivesBooleanResult.booleanAnswer = 1
    let usedAnyContaceptivesStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.usedAnyContraceptivesStepID, results: [usedAnyContraceptivesBooleanResult])
    
    let recentlyDiagnosedBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.recentlyDiagnosedStepID)
    recentlyDiagnosedBooleanResult.booleanAnswer = 1
    let recentlyDiagnosedStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.recentlyDiagnosedStepID, results: [recentlyDiagnosedBooleanResult])
    
    let stillBreastFeedingBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.stillBreastfeedingStepID)
    stillBreastFeedingBooleanResult.booleanAnswer = 0
    let stillBreastfeedingStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.stillBreastfeedingStepID, results: [stillBreastFeedingBooleanResult])
    
    let didMenstruateBooleanResult = ORKBooleanQuestionResult.init(identifier: WeeklySurvey.didMenstruateThisWeekStepID)
    didMenstruateBooleanResult.booleanAnswer = 1
    let didMenstruateStepResult = ORKStepResult.init(stepIdentifier: WeeklySurvey.didMenstruateThisWeekStepID, results: [didMenstruateBooleanResult])
    
    
    results.append(areYouPregnantStepResult)
    results.append(usedAnyContaceptivesStepResult)
    results.append(recentlyDiagnosedStepResult)
    results.append(stillBreastfeedingStepResult)
    results.append(didMenstruateStepResult)
    
    let surveyResults =  TaskViewControllerResults.getViewControllerResults(taskViewControllerResults: results, taskID: WeeklySurvey.taskID)
    
    XCTAssertEqual(surveyResults.results[WeeklySurvey.areYouPregnantStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.usedAnyContraceptivesStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.recentlyDiagnosedStepID], "1")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.stillBreastfeedingStepID], "0")
    XCTAssertEqual(surveyResults.results[WeeklySurvey.didMenstruateThisWeekStepID], "1")
    XCTAssertEqual(surveyResults.results["surveyType"], "WeeklySurvey")
  }
 
  func testDailySurveyOne() {
    let clearBlueTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DailyCycleSurvey.clearBlueMonitorStepID)
    clearBlueTextChoiceResult.choiceAnswers = [0 as NSCoding & NSCopying & NSObjectProtocol]
    let clearBlueMonitorStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.clearBlueMonitorStepID, results: [clearBlueTextChoiceResult])
    
    let progesteroneTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DailyCycleSurvey.progesteroneQuestionStepID)
    progesteroneTextChoiceResult.choiceAnswers = [0 as NSCoding & NSCopying & NSObjectProtocol]
    let progesteroneStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.progesteroneQuestionStepID, results: [progesteroneTextChoiceResult])
    
    let experienceBleedingBooleanResult = ORKBooleanQuestionResult.init(identifier: DailyCycleSurvey.experienceBleedingStepID)
    experienceBleedingBooleanResult.booleanAnswer = 1
    let experienceBleedingStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.experienceBleedingStepID, results: [experienceBleedingBooleanResult])
    
    let menstruationTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DailyCycleSurvey.menstruationQuestionStepID)
    menstruationTextChoiceResult.choiceAnswers = [1 as NSCoding & NSCopying & NSObjectProtocol]
    let menstruationStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.menstruationQuestionStepID, results: [menstruationTextChoiceResult])
    
    let numOfTimesBabyBreastFedNumericAnswer = ORKNumericQuestionResult.init(identifier: DailyCycleSurvey.numOfTimesBabyBreastFedStepID)
    numOfTimesBabyBreastFedNumericAnswer.numericAnswer = 4
    let numOfTimesBabyBreastFedStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.numOfTimesBabyBreastFedStepID, results: [numOfTimesBabyBreastFedNumericAnswer])
    
    let numOfTimesBabyExpressFedNumericAnswer = ORKNumericQuestionResult.init(identifier: DailyCycleSurvey.numOfTimesBabyExpressFedStepID)
    numOfTimesBabyExpressFedNumericAnswer.numericAnswer = 3
    let numOfTimesBabyExpressFedStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.numOfTimesBabyExpressFedStepID, results: [numOfTimesBabyExpressFedNumericAnswer])
  
    let numOfTimesBabyFormulaFedNumericAnswer = ORKNumericQuestionResult.init(identifier: DailyCycleSurvey.numOfTimesBabyFormulaFedStepID)
    numOfTimesBabyFormulaFedNumericAnswer.numericAnswer = 6
    let numOfTimesBabyFormulaFedStepResult = ORKStepResult.init(stepIdentifier: DailyCycleSurvey.numOfTimesBabyFormulaFedStepID, results: [numOfTimesBabyFormulaFedNumericAnswer])
    
    results.append(clearBlueMonitorStepResult)
    results.append(progesteroneStepResult)
    results.append(experienceBleedingStepResult)
    results.append(menstruationStepResult)
    results.append(numOfTimesBabyBreastFedStepResult)
    results.append(numOfTimesBabyExpressFedStepResult)
    results.append(numOfTimesBabyFormulaFedStepResult)
    
    let surveyResults = TaskViewControllerResults.getViewControllerResults(taskViewControllerResults: results, taskID: DailyCycleSurvey.taskID) as? TaskResults
    let processResults = ProcessResults(taskResults: surveyResults)
    processResults.saveResultsToCoreData(taskResults: surveyResults!)
    /*
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.clearBlueMonitorStepID], "0")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.progesteroneQuestionStepID], "0")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.experienceBleedingStepID], "1")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.menstruationQuestionStepID], "1")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyBreastFedStepID], "4")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyExpressFedStepID], "3")
    XCTAssertEqual(surveyResults.results[DailyCycleSurvey.numOfTimesBabyFormulaFedStepID], "6")
    XCTAssertEqual(surveyResults.results["surveyType"], "DailySurvey")*/
  }
  
  func testOnboardingSurvey() {
    
    let biologicalSexTextChoiceResult = ORKChoiceQuestionResult.init(identifier: EligibilitySteps.biologicalSexStepID)
    biologicalSexTextChoiceResult.choiceAnswers = [0 as NSCoding & NSCopying & NSObjectProtocol]//Female
    let biologicalSexStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.biologicalSexStepID, results: [biologicalSexTextChoiceResult])
    results.append(biologicalSexStepResult)
    
    let biologicalInfantBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.biologicalInfantStepID)
    biologicalInfantBooleanResult.booleanAnswer = 1
    let biologicalInfantStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.biologicalInfantStepID, results: [biologicalInfantBooleanResult])
    results.append(biologicalInfantStepResult)
    
    let singletonBirthBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.singletonBirthStepID)
    singletonBirthBooleanResult.booleanAnswer = 1
    let singletonBirthStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.singletonBirthStepID, results: [singletonBirthBooleanResult])
    results.append(singletonBirthStepResult)
    
    let babyBornFullTermBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.babyBornFullTermStep)
    babyBornFullTermBooleanResult.booleanAnswer = 1
    let babyBornFullTermStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.babyBornFullTermStep, results: [babyBornFullTermBooleanResult])
    results.append(babyBornFullTermStepResult)
    
    let particpantAgeInRangeBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.participantAgeInRangeStepID)
    particpantAgeInRangeBooleanResult.booleanAnswer = 1
    let participantAgeInRangeStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.participantAgeInRangeStepID, results: [particpantAgeInRangeBooleanResult])
    results.append(participantAgeInRangeStepResult)
    
    let momHealthBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.momHealthStepID)
    momHealthBooleanResult.booleanAnswer = 0
    let momHealthStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.momHealthStepID, results: [momHealthBooleanResult])
    results.append(momHealthStepResult)
    
    let breastSurgeryBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.breastSurgeryStepID)
    breastSurgeryBooleanResult.booleanAnswer = 0
    let breastSurgeryStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.breastSurgeryStepID, results: [breastSurgeryBooleanResult])
    results.append(breastSurgeryStepResult)
    
    let infantAgeInRangeBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.infantAgeInRangeStepID)
    infantAgeInRangeBooleanResult.booleanAnswer = 1
    let infantAgeInRangeStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.infantAgeInRangeStepID, results: [infantAgeInRangeBooleanResult])
    results.append(infantAgeInRangeStepResult)
    
    let clearBlueMonitorBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.clearBlueMonitorStepID)
    clearBlueMonitorBooleanResult.booleanAnswer = 1
    let clearBlueMonitorStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.clearBlueMonitorStepID, results: [clearBlueMonitorBooleanResult])
    results.append(clearBlueMonitorStepResult)
    
    let canReadEnglishBooleanResult = ORKBooleanQuestionResult.init(identifier: EligibilitySteps.canReadEnglishStepID)
    canReadEnglishBooleanResult.booleanAnswer = 1
    let canReadEnglishStepResult = ORKStepResult.init(stepIdentifier: EligibilitySteps.canReadEnglishStepID, results: [canReadEnglishBooleanResult])
    results.append(canReadEnglishStepResult)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let participantDate = dateFormatter.date(from: "1992-07-13")
    
    let participantBirthDateResult = ORKDateQuestionResult.init(identifier: DemographicSteps.participantBirthDateStepID)
    participantBirthDateResult.dateAnswer = participantDate
    let participantBirthDateStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.participantBirthDateStepID, results: [participantBirthDateResult])
    results.append(participantBirthDateStepResult)
    
    let babyBirthDate = dateFormatter.date(from: "2018-08-12")
    
    let babyBirthDateResult = ORKDateQuestionResult.init(identifier: DemographicSteps.babysBirthDateStepID)
    babyBirthDateResult.dateAnswer = babyBirthDate
    let babyBirthDateStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.babysBirthDateStepID, results: [babyBirthDateResult])
    results.append(babyBirthDateStepResult)
    
    let babyFeedOnDemandChoiceResult = ORKChoiceQuestionResult.init(identifier: DemographicSteps.babyFeedOnDemandStepID)
    babyFeedOnDemandChoiceResult.choiceAnswers = [0 as NSCoding & NSCopying & NSObjectProtocol] // On Demand
    let babyFeedOnDemandStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.babyFeedOnDemandStepID, results: [babyFeedOnDemandChoiceResult])
    results.append(babyFeedOnDemandStepResult)
    
    let breastPumpInfoTextResult = ORKTextQuestionResult.init(identifier: DemographicSteps.breastPumpInfoStepID)
    breastPumpInfoTextResult.textAnswer = "Some Pump"
    let breastPumpInfoStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.breastPumpInfoStepID, results: [breastPumpInfoTextResult])
    results.append(breastPumpInfoStepResult)
    
    let ethnicityTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DemographicSteps.ethnicityStepID)
    ethnicityTextChoiceResult.choiceAnswers = [4 as NSCoding & NSCopying & NSObjectProtocol]//Hispanic
    let ethnicityStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.ethnicityStepID, results: [ethnicityTextChoiceResult])
    results.append(ethnicityStepResult)
    
    let religionTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DemographicSteps.religionStepID)
    religionTextChoiceResult.choiceAnswers = [4 as NSCoding & NSCopying & NSObjectProtocol]//Jewish
    let religionStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.religionStepID, results: [religionTextChoiceResult])
    results.append(religionStepResult)
    
    let levelOfEducationTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DemographicSteps.levelOfEducationStepID)
    levelOfEducationTextChoiceResult.choiceAnswers = [2 as NSCoding & NSCopying & NSObjectProtocol]//College Degree
    let levelOfEducationStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.levelOfEducationStepID, results: [levelOfEducationTextChoiceResult])
    results.append(levelOfEducationStepResult)
    
    let relationshipStatusTextChoiceResult = ORKChoiceQuestionResult.init(identifier: DemographicSteps.relationshipStatusID)
    relationshipStatusTextChoiceResult.choiceAnswers = [0 as NSCoding & NSCopying & NSObjectProtocol]//In a relationship
    let relationshipStatusStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.relationshipStatusID, results: [relationshipStatusTextChoiceResult])
    results.append(relationshipStatusStepResult)
    
    let marriedLengthNumericResult = ORKNumericQuestionResult.init(identifier: DemographicSteps.marriedLengthStepID)
    marriedLengthNumericResult.numericAnswer = 3
    let marriedLengthStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.marriedLengthStepID, results: [marriedLengthNumericResult])
    results.append(marriedLengthStepResult)
    
    let howManyTimesPregnantNumericResult = ORKNumericQuestionResult.init(identifier: DemographicSteps.howManyTimesPregnantStepID)
    howManyTimesPregnantNumericResult.numericAnswer = 2
    let howManyTimesPregnantStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.howManyTimesPregnantStepID, results: [howManyTimesPregnantNumericResult])
    results.append(howManyTimesPregnantStepResult)
    
    let howManyBiologicalChildrenNumericResult = ORKNumericQuestionResult.init(identifier: DemographicSteps.howManyBiologicalChildrenStepID)
    howManyBiologicalChildrenNumericResult.numericAnswer = 1
    let howManyBiologicalChildrenStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.howManyBiologicalChildrenStepID, results: [howManyBiologicalChildrenNumericResult])
    results.append(howManyBiologicalChildrenStepResult)
    
    let howManyChildrenBreastFedNumericResult = ORKNumericQuestionResult.init(identifier: DemographicSteps.howManyChildrenBreastFedStepID)
    howManyChildrenBreastFedNumericResult.numericAnswer = 1
    let howManyChildrenBreastFedStepResult = ORKStepResult.init(stepIdentifier: DemographicSteps.howManyChildrenBreastFedStepID, results: [howManyChildrenBreastFedNumericResult])
    results.append(howManyChildrenBreastFedStepResult)
    
    let surveyResults = TaskViewControllerResults.getViewControllerResults(taskViewControllerResults: results, taskID: Onboarding.taskID)
    
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
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
