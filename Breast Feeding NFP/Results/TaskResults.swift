//
//  CycleTaskResult.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

protocol TaskResults {
  var results: [String: String] {get}
  func enterTaskResult(identifier: String, result: String)
  func getDateAsString() -> String
  func getEntryJSON() -> String
}

class DailyTaskResults: TaskResults {
  
  var results: [String: String] = [
    "userName" : "",
    "date" : "",
    "type": "DailySurvey",
    DailyCycleSurvey.clearBlueMonitorStepID: "-1",
    DailyCycleSurvey.progesteroneQuestionStepID : "-1",
    DailyCycleSurvey.experienceBleedingStepID : "-1",
    DailyCycleSurvey.menstruationQuestionStepID : "-1",
    DailyCycleSurvey.numOfTimesBabyBreastFedStepID : "-1",
    DailyCycleSurvey.numOfTimesBabyExpressFedStepID : "-1",
    DailyCycleSurvey.numOfTimesBabyFormulaFedStepID : "-1"
  ]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }
  func getEntryJSON() -> String {
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8)!
    } catch {
      print(error.localizedDescription)
    }
    return "ERROR PROCESSING SURVEY"
  }
  
  func getDateAsString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    let dateString = dateFormatter.string(from: Date())
    return dateString
  }
}

class WeeklyTaskResults: TaskResults {

  var results: [String: String] = [
    "userName" : "",
    "date" : "",
    "type": "WeeklySurvey",
    WeeklyEligibilitySurvey.areYouPregnantStepID : "-1",
    WeeklyEligibilitySurvey.usedAnyContraceptivesStepID: "-1",
    WeeklyEligibilitySurvey.recentlyDiagnosedStepID: "-1",
    WeeklyEligibilitySurvey.stillBreastfeedingStepID: "-1",
    WeeklyEligibilitySurvey.didMenstruateThisWeekStepID: "-1"]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }
  
  func getDateAsString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    let dateString = dateFormatter.string(from: Date())
    return dateString
  }
  
  func getEntryJSON() -> String {
    results["date"] = getDateAsString()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8)!
    } catch {
      print(error.localizedDescription)
    }
    return "ERROR PROCESSING SURVEY"
  }
}

class OnboardingTaskResults: TaskResults {
  var results: [String : String] = [
    "userName" : "",
    "date" : "",
    "type": "OnboardingSurvey",
    EligibilitySteps.biologicalSexStepID: "-1",
    EligibilitySteps.biologicalInfantStepID: "-1",
    EligibilitySteps.singletonBirthStepID: "-1",
    EligibilitySteps.babyBornFullTermStep: "-1",
    EligibilitySteps.participantAgeInRangeStepID: "-1",
    EligibilitySteps.momHealthStepID: "-1",
    EligibilitySteps.breastSurgeryStepID: "-1",
    EligibilitySteps.infantAgeInRangeStepID: "-1",
    EligibilitySteps.clearBlueMonitorStepID: "-1",
    EligibilitySteps.canReadEnglishStepID: "-1",
    DemographicSteps.participantBirthDateStepID: "-1",
    DemographicSteps.babysBirthDateStepID: "-1",
    DemographicSteps.babyFeedOnDemandStepID: "-1",
    DemographicSteps.breastPumpInfoStepID: "-1",
    DemographicSteps.ethnicityStepID: "-1",
    DemographicSteps.religionStepID: "-1",
    DemographicSteps.levelOfEducationStepID: "-1",
    DemographicSteps.relationshipStatusID: "-1",
    DemographicSteps.marriedLengthStepID: "-1",
    DemographicSteps.howManyTimesPregnantStepID: "-1",
    DemographicSteps.howManyBiologicalChildrenStepID: "-1",
    DemographicSteps.howManyChildrenBreastFedStepID: "-1",
    DemographicSteps.howLongInPastBreastFedStepID: "-1"
  ]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }
  
  func getEntryJSON() -> String {
    results["date"] = getDateAsString()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8)!
    } catch {
      print(error.localizedDescription)
    }
    return "ERROR PROCESSING SURVEY"
  }
  
  func getDateAsString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    let dateString = dateFormatter.string(from: Date())
    return dateString
  }
}

struct StringFormatter {
  static func buildString(stepResultString: String) -> String {
    return stepResultString.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
  }
}
