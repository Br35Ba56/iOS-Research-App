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

import ResearchKit
struct StudyTasks {
  static let dailySurveyTask: ORKNavigableOrderedTask = {
    var steps = [ORKStep]()
    
    
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Daily Survey"
    instructionStep.text = "Please provide information about your cycle."
    steps += [instructionStep]

    
    let clearBlueMontitorAnswerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: DailyCycleSurvey.clearBlueMonitorTextChoices)
    let clearBlueMonitorQuestionStep = ORKQuestionStep(identifier: DailyCycleSurvey.clearBlueMonitorStepID, title: DailyCycleSurvey.clearBlueMonitorStepTitle, answer: clearBlueMontitorAnswerFormat)
    clearBlueMonitorQuestionStep.isOptional = false
    steps += [clearBlueMonitorQuestionStep]
    
    
    let progesteroneAnswerFormat = ORKBooleanAnswerFormat()
    let progesteroneQuestionStep = ORKQuestionStep(identifier: DailyCycleSurvey.progesteroneQuestionStepID, title: DailyCycleSurvey.progesteroneStepTitle, answer: progesteroneAnswerFormat)
    progesteroneQuestionStep.isOptional = false
    steps += [progesteroneQuestionStep]
    
    let progesteroneResultAnswerFormat = ORKBooleanAnswerFormat(yesString: "Positive", noString: "Negative")
    let progesteroneResultQuestionStep = ORKQuestionStep(identifier: DailyCycleSurvey.progesteroneResultStepID, title: DailyCycleSurvey.progesteroneResultStepTitle, answer: progesteroneResultAnswerFormat)
    progesteroneResultQuestionStep.isOptional = false
    steps += [progesteroneResultQuestionStep]
    
    
    let menstruationAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: DailyCycleSurvey.menstruationTextChoices)
    let menstruationQuestionStep = ORKQuestionStep(identifier: DailyCycleSurvey.menstruationQuestionStepID, title: DailyCycleSurvey.menstruationStepTitle, answer: menstruationAnswerFormat)
    menstruationQuestionStep.isOptional = false
    steps += [menstruationQuestionStep]
    
    // Summary step
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thank you."
    summaryStep.text = "We appreciate your time."
    steps += [summaryStep]
    
    let resultSelector = ORKResultSelector(resultIdentifier: DailyCycleSurvey.progesteroneQuestionStepID)
    let predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    let rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate, DailyCycleSurvey.menstruationQuestionStepID)])
    
    let dailySurvey = ORKNavigableOrderedTask(identifier: DailyCycleSurvey.dailySurveyID, steps: steps)
    dailySurvey.setNavigationRule(rule, forTriggerStepIdentifier: DailyCycleSurvey.progesteroneQuestionStepID)
    return dailySurvey
  }()
  
}

struct DailyCycleSurvey {
  static let dailySurveyID = "DailySurveyID"
  static let instructionID = "CycleDataIntroStepID"
  
  //Clear Blue Monitor
  static let clearBlueMonitorStepID = "ClearBlueMonitorStepID"
  static let clearBlueMonitorStepTitle = "Clear Blue Monitor Low, Peek, or High"
  static let clearBlueMonitorTextChoices = [
    ORKTextChoice(text: "Low Fertility", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "High Fertility", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "Peek Fertility", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
    ]
  
  //Progestorone test yes or no
  static let progesteroneQuestionStepID = "ProgesteroneQuestionStepID"
  static let progesteroneStepTitle = "Did you take a progestorone test?"
  
  //Progestorone result if taken
  static let progesteroneResultStepID = "ProgesteroneResultStepID"
  static let progesteroneResultStepTitle = "What was the result of the progestorone test?"
  
  //Menstruation Question
  static let menstruationQuestionStepID = "MenstruationQuestionStepID"
  static let menstruationStepTitle = "Are you experiencing any bleeding?"
  static let menstruationTextChoices = [
    ORKTextChoice(text: "None", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "Spotting", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "Light", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "Moderate", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
    ORKTextChoice(text: "Heavy", value: 4 as NSCoding & NSCopying & NSObjectProtocol)
  ]
  
  
}
