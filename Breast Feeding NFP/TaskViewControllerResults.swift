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
  var taskResults: TaskResults?
  
  private static func getTaskResultType(taskID: String) -> TaskResults {
    if taskID == DailyCycleSurvey.taskID {
      return DailyTaskResults()
    } else if taskID == WeeklySurvey.taskID {
      return WeeklyTaskResults()
    } else {
      return OnboardingTaskResults()
    }
  }
  
  public static func getViewControllerResults(taskViewControllerResults: [ORKStepResult], taskID: String) -> TaskResults {
    
    let taskResults: TaskResults? = getTaskResultType(taskID: taskID)
    
    for stepResult: ORKStepResult in taskViewControllerResults {
      for result in stepResult.results! {
        if let questionResult = result as? ORKChoiceQuestionResult {
          if let anotherResult = questionResult.answer {
            let stringResult = StringFormatter.buildString(stepResultString: (anotherResult as AnyObject).description)
            taskResults?.enterTaskResult(identifier: questionResult.identifier, result: stringResult)
          }
        }
        if let questionResult = result as? ORKBooleanQuestionResult {
          if let finalResult = questionResult.booleanAnswer?.intValue {
            taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
          }
        }
        if let questionResult = result as? ORKDateQuestionResult {
          if let finalResult = questionResult.dateAnswer {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dateFormatter.string(from: finalResult)
            taskResults?.enterTaskResult(identifier: questionResult.identifier, result: dateString)
          }
        }
        if let questionResult = result as? ORKNumericQuestionResult {
          if let finalResult = questionResult.numericAnswer {
            taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
          }
        }
        if let questionResult = result as? ORKTextQuestionResult {
          if let finalResult = questionResult.textAnswer {
            if questionResult.identifier == DemographicSteps.breastPumpInfoStepID {//if needed so other results aren't added, ie password.
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
            }
          }
        }
      }
    }
    taskResults?.enterTaskResult(identifier: "userName", result: KeychainWrapper.standard.string(forKey: "Username")!)
    return taskResults!
  }
}
