//
//  ORKDurationOrderedTask.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/10/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

//TODO: Finish Refactor, super stepAfterStep can be used.

class ORKDurationOrderedTask: ORKOrderedTask {
  override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
    if steps.count <= 0 {
      return nil
    }
    let currentStep = step
    var nextStep: ORKStep? = nil
    if currentStep == nil {
      nextStep = steps[0]
    } else {
      var index = steps.index(of: step!)
      if index == nil {
        index = 2
      }
      if NSNotFound != index && index != steps.count - 1 {
        if index == 1 {
          //TODO: Refactor
          //Sets up a Date Question limiting the min/max date bounderies
          if let taskResult = result.stepResult(forStepIdentifier: DateTimeSurvey.startTimeID) {
            let answer = taskResult.firstResult
            let date = answer as? ORKDateQuestionResult
            if let minimumDate = date?.dateAnswer {
              let userCalander = Calendar.current
              let maximumDate = getMaxDate(minimumDate: minimumDate, userCalander: userCalander)
              let answerStyle = ORKDateAnswerStyle.dateAndTime
              let answerFormat = ORKDateAnswerFormat(style: answerStyle, defaultDate: minimumDate, minimumDate: minimumDate, maximumDate: maximumDate, calendar: userCalander)
              nextStep = ORKQuestionStep(identifier: DateTimeSurvey.stopTimeID, title: "Stop Time", text: nil, answer: answerFormat)
              nextStep?.isOptional = false
            }
          }
          return nextStep
        }
        nextStep = steps[index! + 1]
      }
    }
    return nextStep
  }
  
  private func getMaxDate(minimumDate: Date, userCalander: Calendar) -> Date {
    let dateComponents = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute], from: minimumDate, to: Date())
    let hour = Int(dateComponents.hour!)
    let min = Int(dateComponents.minute!)
    
    if hour >= 1 {
      let maximumDate = userCalander.date(byAdding: .hour, value: 1, to: minimumDate)
      return maximumDate!
    } else {
      let maximumDate = userCalander.date(byAdding: .minute, value: min, to: minimumDate)
      return maximumDate!
    }
  }
}
