//
//  TaskViewControllerResults.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/18/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

struct TaskViewControllerResults {
  public static func getViewControllerResults(taskViewController: ORKTaskViewController) -> TaskResults {
    var taskResults: TaskResults?
    if taskViewController.task!.identifier == DailyCycleSurvey.taskID {
      taskResults = DailyTaskResults()
    } else if taskViewController.task!.identifier == WeeklySurvey.taskID {
      taskResults = WeeklyTaskResults()
    } else if taskViewController.task!.identifier == Onboarding.task {
      taskResults = OnboardingTaskResults()
    }
    if let results = taskViewController.result.results as? [ORKStepResult] {
      for stepResult: ORKStepResult in results {
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
              dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
              let dateString = dateFormatter.string(from: finalResult)
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: dateString)
            }
          }
          if let questionResult = result as? ORKNumericQuestionResult {
            if let finalResult = questionResult.numericAnswer {
              taskResults?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
            }
          }
        }
      }
    }
    return taskResults!
  }
}
