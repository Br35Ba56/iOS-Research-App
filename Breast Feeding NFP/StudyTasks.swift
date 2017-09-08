/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//  StudyTasks.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//
//TODO: Refactor to be formatted as onboarding survey.
import ResearchKit
struct StudyTasks {
  
  static let dailySurveyTask: ORKNavigableOrderedTask = {
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Daily Menstrual Cycle Events"
    instructionStep.text = "Please provide information about your cycle."
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thank you."
    summaryStep.text = "We appreciate your time."
    
    let task = ORKNavigableOrderedTask(identifier: "DailyMenstraulCycleEventsID", steps: [
      instructionStep,
      clearBlueMonitorStep,
      progesteroneStep,
      progesteroneResultStep,
      menstruationStep,
      summaryStep])
    
    var resultSelector = ORKResultSelector(resultIdentifier: DailyCycleSurvey.progesteroneQuestionStepID)
    let predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    var rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate, DailyCycleSurvey.menstruationQuestionStepID)])
    task.setNavigationRule(rule, forTriggerStepIdentifier: DailyCycleSurvey.progesteroneQuestionStepID)
    
    resultSelector = ORKResultSelector(resultIdentifier: DailyCycleSurvey.clearBlueMonitorStepID)
    let expectedAnswer1 = 0 as NSCoding & NSCopying & NSObjectProtocol
    let predicate1 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: expectedAnswer1)
    let expectedAnswer2 = 1 as NSCoding & NSCopying & NSObjectProtocol
    let predicate2 = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: expectedAnswer2)
    rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate1, DailyCycleSurvey.menstruationQuestionStepID),
                                                                                          (predicate2, DailyCycleSurvey.menstruationQuestionStepID)])
    task.setNavigationRule(rule, forTriggerStepIdentifier: DailyCycleSurvey.clearBlueMonitorStepID)
    
    return task
  }()
  //TODO: Finish Refactor
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
            if let taskResult = result.stepResult(forStepIdentifier: "Start") {
              let answer = taskResult.firstResult
              let date = answer as? ORKDateQuestionResult
              if let minimumDate = date?.dateAnswer {
                let userCalander = Calendar.current
                let maximumDate = userCalander.date(byAdding: .hour, value: 1, to: minimumDate)
                let answerStyle = ORKDateAnswerStyle.dateAndTime
                let answerFormat = ORKDateAnswerFormat(style: answerStyle, defaultDate: minimumDate, minimumDate: minimumDate, maximumDate: maximumDate, calendar: userCalander)
                nextStep = ORKQuestionStep(identifier: "Stop", title: "Stop Time", text: nil, answer: answerFormat)
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
  }
  
  private static let manualBreastFedStartStep: ORKStep = {
    let userCalendar = Calendar.current
    let minimumDate = userCalendar.date(byAdding: .day, value: -2, to: Date())
    let answerStyle = ORKDateAnswerStyle.dateAndTime
    
    let answerFormat = ORKDateAnswerFormat(style: answerStyle, defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), calendar: userCalendar)
    let manualBreastFedStartStep = ORKQuestionStep(identifier: "Start", title: "Start Time", answer: answerFormat)
    manualBreastFedStartStep.isOptional = false
    return manualBreastFedStartStep
  }()
  
  static let manualBreastFeedTask: ORKDurationOrderedTask = {
    let instructionStep = ORKInstructionStep(identifier: "Instructions")
    instructionStep.title = "Breast Feeding Entry"
    instructionStep.text = "Please enter the start and stop times you breast fed your baby."
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Thank you for your entry!"
    let reviewStep = ORKReviewStep.embeddedReviewStep(withIdentifier: "review")
    let orderedTask = ORKDurationOrderedTask(identifier: "BreastFeedingManualID", steps: [
      instructionStep,
      manualBreastFedStartStep,
      manualBreastFedStopStep,
      reviewStep,
      completionStep
      ])
    
    return orderedTask
  }()
  
  private static var manualBreastFedStopStep: ORKStep = {
    let userCalendar = Calendar.current
    let minimumDate = userCalendar.date(byAdding: .day, value: -2, to: Date())
    let answerStyle = ORKDateAnswerStyle.dateAndTime
    let answerFormat = ORKDateAnswerFormat(style: answerStyle, defaultDate: Date(), minimumDate: minimumDate, maximumDate: Date(), calendar: userCalendar)
    let manualBreastFedStopStep = ORKQuestionStep(identifier: "Stop", title: "Stop Time", answer: answerFormat)
    manualBreastFedStopStep.isOptional = false
    return manualBreastFedStopStep
  }()
  
  private static let clearBlueMonitorStep: ORKStep = {
    var title = "Clear Blue Monitor Low, Peek, or High"
    let textChoices = [
      ORKTextChoice(text: "Low Fertility", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "High Fertility", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Peek Fertility", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
      ]
    let answerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let clearBlueMonitorQuestionStep = ORKQuestionStep(identifier: DailyCycleSurvey.clearBlueMonitorStepID, title: title, answer: answerFormat)
    clearBlueMonitorQuestionStep.isOptional = false
    return clearBlueMonitorQuestionStep
  }()
  
  private static let progesteroneStep: ORKStep = {
    let title = "Did you take a progestorone test?"
    let answerFormat = ORKBooleanAnswerFormat()
    let progesteroneStep = ORKQuestionStep(identifier: DailyCycleSurvey.progesteroneQuestionStepID, title: title, answer: answerFormat)
    progesteroneStep.isOptional = false
    return progesteroneStep
  }()
  
  private static let progesteroneResultStep: ORKStep = {
    let title = "What was the result of the progestorone test?"
    let answerFormat = ORKBooleanAnswerFormat(yesString: "Positive", noString: "Negative")
    let progesteroneResultStep = ORKQuestionStep(identifier: DailyCycleSurvey.progesteroneResultStepID, title: title, answer: answerFormat)
    progesteroneResultStep.isOptional = false
    return progesteroneResultStep
  }()
  
  private static let menstruationStep: ORKStep = {
    let title = "Are you experiencing any bleeding?"
    let textChoices = [
      ORKTextChoice(text: "None", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Spotting", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Light", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Moderate", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Heavy", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let menstruationStep = ORKQuestionStep(identifier: DailyCycleSurvey.menstruationQuestionStepID, title: title, answer: answerFormat)
    menstruationStep.isOptional = false
    return menstruationStep
  }()
}

struct DailyCycleSurvey {
  static let dailySurveyID = "DailySurveyID"
  static let instructionID = "CycleDataIntroStepID"
  static let clearBlueMonitorStepID = "ClearBlueMonitorStepID"
  static let progesteroneQuestionStepID = "ProgesteroneStepID"
  static let progesteroneResultStepID = "ProgesteroneResultStepID"
  static let menstruationQuestionStepID = "MenstruationQuestionStepID"
  
}
