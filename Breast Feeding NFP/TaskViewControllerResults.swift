//
//  TaskViewControllerResults.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/18/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit
import SwiftKeychainWrapper

struct TaskViewControllerResults {

  public static func getViewControllerResults(taskViewControllerResults: [ORKStepResult], taskID: String) -> TaskResults {
    
    var taskResults: TaskResults?
    if taskID == DailyCycleSurvey.taskID {
      taskResults = DailyTaskResults()
    } else if taskID == WeeklySurvey.taskID {
      taskResults = WeeklyTaskResults()
    } else if taskID == Onboarding.taskID {
      taskResults = OnboardingTaskResults()
    }
    
      for stepResult: ORKStepResult in taskViewControllerResults {
        for result in stepResult.results! {
          
          if let questionResult = result as? ORKBooleanQuestionResult {
            questionResult.booleanAnswer = false
            if let finalResult = questionResult.booleanAnswer?.intValue {
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
            }
          }
          if let questionResult = result as? ORKDateQuestionResult {
            if let finalResult = questionResult.dateAnswer {
              let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
              let dateString = dateFormatter.string(from: finalResult)
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: dateString)
            }
          }
          if let questionResult = result as? ORKNumericQuestionResult {
            questionResult.numericAnswer = 44
            if let finalResult = questionResult.numericAnswer {
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
            }
          }
          if let questionResult = result as? ORKTextQuestionResult {
            if let finalResult = questionResult.textAnswer {
              if questionResult.identifier == DemographicSteps.breastPumpInfoStepID {
                taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
              }
            }
          }
        }
      }
      //TODO: Refractor into TaskResults.swift
      taskResults?.enterTaskResult(identifier: "userName", result: KeychainWrapper.standard.string(forKey: "Username")!)
    print(taskResults?.getEntryJSON())
    return taskResults!
  }
}
