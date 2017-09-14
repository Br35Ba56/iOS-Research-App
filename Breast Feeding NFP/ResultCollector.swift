//
//  CycleTaskResult.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation

protocol ResultCollector {
  var results: [String: String] {get}
  func getEntryString() -> String
  func enterTaskResult(identifier: String, result: String)
}

class CycleTaskResult: ResultCollector {

  var results: [String: String] = [
    DailyCycleSurvey.clearBlueMonitorStepID: "-1",
    DailyCycleSurvey.progesteroneQuestionStepID : "-1",
    DailyCycleSurvey.progesteroneResultStepID : "-1",
    DailyCycleSurvey.menstruationQuestionStepID : "-1"
  ]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }
  
  func getEntryString() -> String{
    return "\(String(describing: results[DailyCycleSurvey.clearBlueMonitorStepID]!)), \(String(describing: results[DailyCycleSurvey.progesteroneQuestionStepID]!)), \(String(describing: results[DailyCycleSurvey.progesteroneResultStepID]!)), \(String(describing: results[DailyCycleSurvey.menstruationQuestionStepID]!))"
  }
}

class DateTimeEntryResult: ResultCollector {

  var results: [String: String] = [DateTimeSurvey.startTimeID : "",
                                   DateTimeSurvey.stopTimeID : ""]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }

  func getEntryString() -> String {
    let dateComponents = getDuration()
    return "\(results[DateTimeSurvey.startTimeID]!), \(results[DateTimeSurvey.stopTimeID]!), \(String(describing: dateComponents.hour!)):\(String(describing: dateComponents.minute!))"
  }
  
  private func getDuration() -> DateComponents {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    let startDate: Date! = dateFormatter.date(from: results[DateTimeSurvey.startTimeID]!)
    let endDate: Date! = dateFormatter.date(from: results[DateTimeSurvey.stopTimeID]!)
    let dateComponents = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: startDate, to: endDate)
    return dateComponents
  }
}

class OnboardingResults: ResultCollector {
  var results: [String : String] = [EligibilitySteps.biologicalInfantStepID: "-1",
                                    EligibilitySteps.singletonBirthStepID: "-1",
                                    EligibilitySteps.babyHealthStepID: "-1",
                                    EligibilitySteps.momHealthStepID: "-1",
                                    EligibilitySteps.breastSurgeryStepID: "-1",
                                    EligibilitySteps.participantAgeInRangeStepID: "-1",
                                    EligibilitySteps.infantAgeInRangeStepID: "-1",
                                    EligibilitySteps.clearBlueMonitorStepID: "-1",
                                    DemographicSteps.participantBirthDateStepID: "-1",
                                    DemographicSteps.babysBirthDateStepID: "-1",
                                    DemographicSteps.ethnicityStepID: "-1",
                                    DemographicSteps.levelOfEducationStepID: "-1",
                                    DemographicSteps.maritalStatusStepID: "-1",
                                    DemographicSteps.marriedLengthStepID: "-1",
                                    DemographicSteps.howManyChildrenStepID: "-1",
                                    ]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }
  
  func getEntryString() -> String {
    return "\(results[EligibilitySteps.biologicalInfantStepID]!), \(results[EligibilitySteps.singletonBirthStepID]!), \(results[EligibilitySteps.babyHealthStepID]!), \(results[EligibilitySteps.momHealthStepID]!), \(results[EligibilitySteps.breastSurgeryStepID]!), \(results[EligibilitySteps.participantAgeInRangeStepID]!), \(results[EligibilitySteps.infantAgeInRangeStepID]!), \(results[EligibilitySteps.clearBlueMonitorStepID]!), \(results[DemographicSteps.participantBirthDateStepID]!), \(results[DemographicSteps.babysBirthDateStepID]!), \(results[DemographicSteps.ethnicityStepID]!), \(results[DemographicSteps.levelOfEducationStepID]!), \(results[DemographicSteps.maritalStatusStepID]!), \(results[DemographicSteps.marriedLengthStepID]!), \(results[DemographicSteps.howManyChildrenStepID]!)"
  }
  
}

struct StringFormatter {
  static func buildString(stepResultString: String) -> String {
    return stepResultString.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
  }
}
