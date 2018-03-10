//
//  CycleTaskResult.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation

protocol TaskResults {
  var results: [String: String] {get}
  func getEntryString() -> String
  func enterTaskResult(identifier: String, result: String)
}

class CycleTaskResults: TaskResults {

  var results: [String: String] = [
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
  
  func getEntryString() -> String{
    return "\(String(describing: results[DailyCycleSurvey.clearBlueMonitorStepID]!)), \(String(describing: results[DailyCycleSurvey.progesteroneQuestionStepID]!)), \(String(describing: results[DailyCycleSurvey.experienceBleedingStepID]!)), \(String(describing: results[DailyCycleSurvey.menstruationQuestionStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyBreastFedStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyExpressFedStepID]!)), \(String(describing: results[DailyCycleSurvey.numOfTimesBabyFormulaFedStepID]!)) "
  }
}

class BreastFeedingTaskResults: TaskResults {

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

class OnboardingTaskResults: TaskResults {
  var results: [String : String] = [EligibilitySteps.biologicalSexStepID: "-1",
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
                                    DemographicSteps.relationShipStatusID: "-1",
                                    DemographicSteps.marriedLengthStepID: "-1",
                                    DemographicSteps.howManyTimesPregnantStepID: "-1",
                                    DemographicSteps.howManyBiologicalChildrenStepID: "-1",
                                    DemographicSteps.howManyChildrenBreastFedStepID: "-1",
                                    DemographicSteps.howLongInPastBreastFedStepID: "-1"
                                    ]
  
  func enterTaskResult(identifier: String, result: String) {
    results[identifier] = result
  }

  func getEntryString() -> String {
    return "\(results[EligibilitySteps.biologicalSexStepID]!), \(results[EligibilitySteps.biologicalInfantStepID]!), \(results[EligibilitySteps.singletonBirthStepID]!), \(results[EligibilitySteps.babyBornFullTermStep]!), \(results[EligibilitySteps.participantAgeInRangeStepID]!), \(results[EligibilitySteps.momHealthStepID]!), \(results[EligibilitySteps.breastSurgeryStepID]!), \(results[EligibilitySteps.infantAgeInRangeStepID]!), \(results[EligibilitySteps.clearBlueMonitorStepID]!), \(results[EligibilitySteps.canReadEnglishStepID]!), \(results[DemographicSteps.participantBirthDateStepID]!), \(results[DemographicSteps.babysBirthDateStepID]!), \(results[DemographicSteps.babyFeedOnDemandStepID]!), \(results[DemographicSteps.breastPumpInfoStepID]!), \(results[DemographicSteps.ethnicityStepID]!), \(results[DemographicSteps.religionStepID]!), \(results[DemographicSteps.levelOfEducationStepID]!), \(results[DemographicSteps.relationShipStatusID]!), \(results[DemographicSteps.marriedLengthStepID]!), \(results[DemographicSteps.howManyTimesPregnantStepID]!), \(results[DemographicSteps.howManyBiologicalChildrenStepID]!), \(results[DemographicSteps.howManyChildrenBreastFedStepID]!), \(results[DemographicSteps.howLongInPastBreastFedStepID]!)"
  }
}

struct StringFormatter {
  static func buildString(stepResultString: String) -> String {
    return stepResultString.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
  }
}
