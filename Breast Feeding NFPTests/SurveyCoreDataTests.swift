//
//  SurveyCoreDataTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 11/30/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest

@testable import Breast_Feeding_NFP

class SurveyCoreDataTests: XCTestCase {
  
  
  override func setUp() {
    eraseAllSurveys()
  }
  
  override func tearDown() {
    eraseAllSurveys()
  }
  
  func testSurveyDelete() {
    let createResults = CreateResults()
    var surveyResultsOne = createResults.getWeeklyResultsOne()
    var surveyResultsTwo = createResults.getWeeklyResultsTwo()
    
    surveyResultsOne.results["date"] = "2018-06-11"
    surveyResultsTwo.results["date"] = "2018-06-18"
    ProcessResults.saveResultsToCoreData(taskResults: surveyResultsOne)
    ProcessResults.saveResultsToCoreData(taskResults: surveyResultsTwo)
    
    let coreDataSurveyManager = CoreDataSurveyManager()
    coreDataSurveyManager.deleteUploadedSurvey(taskResult: surveyResultsOne)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: surveyResultsOne.results["type"]!)
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      let data = result as! [NSManagedObject]
      if data.count == 1 {
        XCTAssertTrue(true)
      }
    } catch {
      XCTAssertTrue(false)
    }
  }
  
  func testDailySurveyCoreDataSave() {
    let createResults = CreateResults()
    let surveyResults = createResults.getDailyResults()
    
    ProcessResults.saveResultsToCoreData(taskResults: surveyResults)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailySurvey")
    request.returnsObjectsAsFaults = false
    
    do {
      let result = try context.fetch(request)
      let data = result[0] as! NSManagedObject
      
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.clearBlueMonitorStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.progesteroneQuestionStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.experienceBleedingStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.menstruationQuestionStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.numOfTimesBabyBreastFedStepID) as! String, "4")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.numOfTimesBabyExpressFedStepID) as! String, "3")
      XCTAssertEqual(data.value(forKey: DailyCycleSurvey.numOfTimesBabyFormulaFedStepID) as! String, "6")
      XCTAssertEqual(data.value(forKey: "type") as! String, "DailySurvey")
      XCTAssertEqual(data.value(forKey: "uploaded") as! Bool, false)
    } catch {
      XCTFail()
    }
  }
  
  func testWeeklySurveyCoreDataSave() {
    let createResults = CreateResults()
    let surveyResults = createResults.getWeeklyResultsTwo()
    
    ProcessResults.saveResultsToCoreData(taskResults: surveyResults)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeeklySurvey")
    request.returnsObjectsAsFaults = false
    
    do {
      let result = try context.fetch(request)
      let data = result[0] as! NSManagedObject
      
      XCTAssertEqual(data.value(forKey: WeeklyEligibilitySurvey.areYouPregnantStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: WeeklyEligibilitySurvey.usedAnyContraceptivesStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: WeeklyEligibilitySurvey.recentlyDiagnosedStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: WeeklyEligibilitySurvey.stillBreastfeedingStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: WeeklyEligibilitySurvey.didMenstruateThisWeekStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: "type") as! String, "WeeklySurvey")
      XCTAssertEqual(data.value(forKey: "uploaded") as! Bool, false)
    } catch {
      XCTFail()
    }
  }
  
  func testOnboardingSurveyCoreDataSave() {
    let createResults = CreateResults()
    let surveyResults = createResults.getOnboardingResults()
    ProcessResults.saveResultsToCoreData(taskResults: surveyResults)
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OnboardingSurvey")
    request.returnsObjectsAsFaults = false
    
    do {
      let result = try context.fetch(request)
      let data = result[0] as! NSManagedObject
      print(data.debugDescription)
      print(data.value(forKey: EligibilitySteps.biologicalSexStepID))
      XCTAssertEqual(data.value(forKey: EligibilitySteps.biologicalSexStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.biologicalInfantStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.singletonBirthStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.babyBornFullTermStep) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.participantAgeInRangeStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.momHealthStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.breastSurgeryStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.infantAgeInRangeStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.clearBlueMonitorStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: EligibilitySteps.canReadEnglishStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: DemographicSteps.participantBirthDateStepID) as! String, "1992-07-13 00:00:00")
      XCTAssertEqual(data.value(forKey: DemographicSteps.babysBirthDateStepID) as! String, "2018-08-12 00:00:00")
      XCTAssertEqual(data.value(forKey: DemographicSteps.babyFeedOnDemandStepID) as! String, "0")
      XCTAssertEqual(data.value(forKey: DemographicSteps.breastPumpInfoStepID) as! String, "Some Pump")
      XCTAssertEqual(data.value(forKey: DemographicSteps.ethnicityStepID) as! String, "4")
      XCTAssertEqual(data.value(forKey: DemographicSteps.religionStepID) as! String, "4")
      XCTAssertEqual(data.value(forKey: DemographicSteps.levelOfEducationStepID) as! String, "2")
      XCTAssertEqual(data.value(forKey: DemographicSteps.relationshipStatusID) as! String, "0")
      XCTAssertEqual(data.value(forKey: DemographicSteps.howManyTimesPregnantStepID) as! String, "2")
      XCTAssertEqual(data.value(forKey: DemographicSteps.howManyBiologicalChildrenStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: DemographicSteps.howManyChildrenBreastFedStepID) as! String, "1")
      XCTAssertEqual(data.value(forKey: DemographicSteps.howLongInPastBreastFedStepID) as! String, "-1")
      
      XCTAssertEqual(data.value(forKey: "type") as! String, "OnboardingSurvey")
      XCTAssertEqual(data.value(forKey: "uploaded") as! Bool, false)
    } catch {
      XCTFail()
    }
  }
  
  func eraseAllSurveys() {
    eraseDailySurveys()
    eraseWeeklySurveys()
    eraseOnboardingSurveys()
  }
  
  func eraseDailySurveys() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailySurvey")
    do {
      if let results = try context.fetch(request) as? [NSManagedObject] {
        for managedObject in results {
          let managedObjectData:NSManagedObject = managedObject
          context.delete(managedObjectData)
        }
      }
      try context.save()
    } catch {
      print("failed to delete")
    }
  }
  
  func eraseWeeklySurveys() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "WeeklySurvey")
    do {
      if let results = try context.fetch(request) as? [NSManagedObject] {
        for managedObject in results {
          let managedObjectData:NSManagedObject = managedObject
          context.delete(managedObjectData)
        }
      }
      try context.save()
    } catch {
      print("failed to delete")
    }
  }
  
  func eraseOnboardingSurveys() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OnboardingSurvey")
    do {
      if let results = try context.fetch(request) as? [NSManagedObject] {
        for managedObject in results {
          let managedObjectData:NSManagedObject = managedObject
          context.delete(managedObjectData)
        }
      }
      try context.save()
    } catch {
      print("failed to delete")
    }
  }
}
