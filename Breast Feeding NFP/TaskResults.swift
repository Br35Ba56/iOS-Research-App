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
  func getEntryString() -> String
  func enterTaskResult(identifier: String, result: String)
  func getDateAsString() -> String
  func getEntryJSON() -> String
}

class DailyTaskResults: TaskResults {
  
  var results: [String: String] = [
    "userName" : "",
    "date" : "",
    "surveyType": "DailySurvey",
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
    results["date"] = getDateAsString()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: results, options: .prettyPrinted)
      return String(data: jsonData, encoding: .utf8)!
    } catch {
      print(error.localizedDescription)
    }
    return "ERROR PROCESSING SURVEY"
  }
  func getEntryString() -> String{
    
    return "\(getDateAsString()), \(String(describing: results[DailyCycleSurvey.clearBlueMonitorStepID]!)), \(String(describing: results[DailyCycleSurvey.progesteroneQuestionStepID]!)), \(String(describing: results[DailyCycleSurvey.experienceBleedingStepID]!)), \(String(describing: results[DailyCycleSurvey.menstruationQuestionStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyBreastFedStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyExpressFedStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyFormulaFedStepID]!)) "
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
    "surveyType": "WeeklySurvey",
    WeeklySurvey.areYouPregnantStepID : "-1",
    WeeklySurvey.usedAnyContraceptivesStepID: "-1",
    WeeklySurvey.recentlyDiagnosedStepID: "-1",
    WeeklySurvey.stillBreastfeedingStepID: "-1",
    WeeklySurvey.didMenstruateThisWeekStepID: "-1"]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }

  func getEntryString() -> String {
    return "\(results[WeeklySurvey.areYouPregnantStepID]!), \(results[WeeklySurvey.usedAnyContraceptivesStepID]!), \(results[WeeklySurvey.recentlyDiagnosedStepID]!), \(results[WeeklySurvey.stillBreastfeedingStepID]!), \(results[WeeklySurvey.didMenstruateThisWeekStepID]!)"
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
    return ""
  }
}

class OnboardingTaskResults: TaskResults {
  var results: [String : String] = [
    "userName" : "",
    "date" : "",
    "surveyType": "OnboardingSurvey",
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
    return ""
  }

  func getEntryString() -> String {
    return "\(results[EligibilitySteps.biologicalSexStepID]!), \(results[EligibilitySteps.biologicalInfantStepID]!), \(results[EligibilitySteps.singletonBirthStepID]!), \(results[EligibilitySteps.babyBornFullTermStep]!), \(results[EligibilitySteps.participantAgeInRangeStepID]!), \(results[EligibilitySteps.momHealthStepID]!), \(results[EligibilitySteps.breastSurgeryStepID]!), \(results[EligibilitySteps.infantAgeInRangeStepID]!), \(results[EligibilitySteps.clearBlueMonitorStepID]!), \(results[EligibilitySteps.canReadEnglishStepID]!), \(results[DemographicSteps.participantBirthDateStepID]!), \(results[DemographicSteps.babysBirthDateStepID]!), \(results[DemographicSteps.babyFeedOnDemandStepID]!), \(results[DemographicSteps.breastPumpInfoStepID]!), \(results[DemographicSteps.ethnicityStepID]!), \(results[DemographicSteps.religionStepID]!), \(results[DemographicSteps.levelOfEducationStepID]!), \(results[DemographicSteps.relationshipStatusID]!), \(results[DemographicSteps.marriedLengthStepID]!), \(results[DemographicSteps.howManyTimesPregnantStepID]!), \(results[DemographicSteps.howManyBiologicalChildrenStepID]!), \(results[DemographicSteps.howManyChildrenBreastFedStepID]!), \(results[DemographicSteps.howLongInPastBreastFedStepID]!)"
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
