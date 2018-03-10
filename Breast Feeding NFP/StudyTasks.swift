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
  
   //MARK: Daily Survey Task
  static let dailySurveyTask: ORKNavigableOrderedTask = {
    let instructionStep = ORKInstructionStep(identifier: "IntroStep")
    instructionStep.title = "Daily Survey"
    
    let summaryStep = ORKCompletionStep(identifier: "SummaryStep")
    summaryStep.title = "Thank you."
    summaryStep.text = "We appreciate your time."

    let task = ORKNavigableOrderedTask(identifier: DailyCycleSurvey.taskID, steps: [
      instructionStep,
      clearBlueMonitorStep,
      progesteroneStep,
      experienceBleedingStep,
      menstruationStep,
      numOfTimesBabyBreastFedStep,
      numOfTimesBabyExpressFedStep,
      numOfTimesBabyFormulaFedStep,
      summaryStep])
    
    var resultSelector = ORKResultSelector(resultIdentifier: DailyCycleSurvey.experienceBleedingStepID)
    let predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    var rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate, DailyCycleSurvey.numOfTimesBabyBreastFedStepID)])
    task.setNavigationRule(rule, forTriggerStepIdentifier: DailyCycleSurvey.experienceBleedingStepID)
        
    return task
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
    let textChoices = [
      ORKTextChoice(text: "Positive", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Negative", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
      ORKTextChoice(text: "Not taken", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
      ]
    let answerFormat: ORKTextChoiceAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
    let progesteroneStep = ORKQuestionStep(identifier: DailyCycleSurvey.progesteroneQuestionStepID, title: title, answer: answerFormat)
    progesteroneStep.isOptional = false
    return progesteroneStep
  }()
  
  private static let experienceBleedingStep: ORKStep = {
    let title = "Did you experience any vaginal bleeding today?"
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let experienceAnyBleedingStep = ORKQuestionStep(identifier: DailyCycleSurvey.experienceBleedingStepID, title: title, answer: answerFormat)
    experienceAnyBleedingStep.isOptional = false
    return experienceAnyBleedingStep
  }()
  
  private static let menstruationStep: ORKStep = {
    let title = "Did you experience any vaginal bleeding today?"
    let textChoices = [
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
  
  private static let numOfTimesBabyBreastFedStep: ORKStep = {
    let title = "Baby fed amount"
    let text = "How many times did your baby breastfeed in the last 24 hours?"
    let answerFormat = ORKNumericAnswerFormat.init(style: ORKNumericAnswerStyle.integer, unit: "amount", minimum: 0, maximum: 30)
    let numOfTimesBabyBreastFedStep = ORKQuestionStep(identifier: DailyCycleSurvey.numOfTimesBabyBreastFedStepID, title: title, text: text, answer: answerFormat)
    return numOfTimesBabyBreastFedStep
  }()
  
  private static let numOfTimesBabyExpressFedStep: ORKStep = {
    let title = "Baby fed amount"
    let text = "How many times did your baby recieve expressed breast milk in the last 24 hours?"
    let answerFormat = ORKNumericAnswerFormat.init(style: ORKNumericAnswerStyle.integer, unit: "amount", minimum: 0, maximum: 30)
    let numOfTimesBabyExpressFedStep = ORKQuestionStep(identifier: DailyCycleSurvey.numOfTimesBabyExpressFedStepID, title: title, text: text, answer: answerFormat)
    return numOfTimesBabyExpressFedStep
  }()
  
  private static let numOfTimesBabyFormulaFedStep: ORKStep = {
    let title = "Baby fed amount"
    let text = "How many times did your baby recieve formula or other supplements in the last 24 hours?"
    let answerFormat = ORKNumericAnswerFormat.init(style: ORKNumericAnswerStyle.integer, unit: "amount", minimum: 0, maximum: 30)
    let numOfTimesBabyFormulaFedStep = ORKQuestionStep(identifier: DailyCycleSurvey.numOfTimesBabyFormulaFedStepID, title: title, text: text, answer: answerFormat)
    return numOfTimesBabyFormulaFedStep
  }()
  
  //MARK: Weekly Survey
  static let manualBreastFeedTask: ORKOrderedTask = {
    let instructionStep = ORKInstructionStep(identifier: "Instructions")
    instructionStep.title = "Weekly Survey"
    instructionStep.text = "Please complete this survey to determine if your still eligible for the study."
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Thank you for your entry!"

    let orderedTask = ORKOrderedTask(identifier: WeeklySurvey.taskID, steps: [
      instructionStep,
      areYouPregnantStep,
      usedAnyContraceptivesStep,
      recentlyDiagnosedStep,
      stillBreastfeedingStep,
      didMenstruateThisWeekStep,
      completionStep
      ])
    
    return orderedTask
  }()
  
  private static let areYouPregnantStep: ORKStep = {
    let title = "Are you pregnant?"
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let areYouPregnantStep = ORKQuestionStep(identifier: WeeklySurvey.areYouPregnantStepID, title: title, answer: answerFormat)
    areYouPregnantStep.isOptional = false
    return areYouPregnantStep
  }()
  
  private static let usedAnyContraceptivesStep: ORKStep = {
    let title = "Contraceptives"
    let text = "Have you used any hormonal contraceptives including emergency contraception this past week?"
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let usedAnyContraceptivesStep = ORKQuestionStep(identifier: WeeklySurvey.usedAnyContraceptivesStepID, title: title, text: text, answer: answerFormat)
    usedAnyContraceptivesStep.isOptional = false
    return usedAnyContraceptivesStep
  }()
  
  private static let recentlyDiagnosedStep: ORKStep = {
    let title = "Diagnosed"
    let text = "Have you recently been diagnosed with type 2 diabetes mellitus or polysticic ovarian syndrome?"
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let recentlyDiagnosedStep = ORKQuestionStep(identifier: WeeklySurvey.recentlyDiagnosedStepID, title: title, text: text, answer: answerFormat)
    recentlyDiagnosedStep.isOptional = false
    return recentlyDiagnosedStep
  }()
  
  private static let stillBreastfeedingStep: ORKStep = {
    let title = "Still Breastfeeding?"
    let text = "Are you still breastfeeding?"
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let stillBreastFeedingStep = ORKQuestionStep(identifier: WeeklySurvey.stillBreastfeedingStepID, title: title, text: text, answer: answerFormat)
    stillBreastFeedingStep.isOptional = false
    return stillBreastFeedingStep
  }()
  
  private static let didMenstruateThisWeekStep: ORKStep = {
    let title = "Did you menstruate this week?"
    let text = "Menstruation occured if bleeding occured with crescendo-decrescendo or decrescendo-crescendo-decrescendo pattern."
    let answerFormat = ORKAnswerFormat.booleanAnswerFormat(withYesString: "Yes", noString: "No")
    let didMenstruateThisWeekStep = ORKQuestionStep(identifier: WeeklySurvey.didMenstruateThisWeekStepID, title: title, text: text, answer: answerFormat)
    didMenstruateThisWeekStep.isOptional = false
    return didMenstruateThisWeekStep
  }()
  
  

}

//MARK: Step IDs
struct WeeklySurvey {
  static let taskID = "weeklySurveyID"
  static let areYouPregnantStepID = "areYouPregnantStepID"
  static let usedAnyContraceptivesStepID = "usedAnyContraceptivesStepID"
  static let recentlyDiagnosedStepID = "recentlyDiagnosedStepID"
  static let stillBreastfeedingStepID = "stillBreastfeedingStepID"
  static let didMenstruateThisWeekStepID = "didMenstruateThisWeekStepID"
}

struct DailyCycleSurvey {
  static let taskID = "dailyCycleSurveyID"
  static let instructionID = "cycleDataIntroStepID"
  static let clearBlueMonitorStepID = "clearBlueMonitorStepID"
  static let progesteroneQuestionStepID = "progesteroneStepID"
  static let experienceBleedingStepID = "experienceBleedingStepID"
  static let menstruationQuestionStepID = "menstruationQuestionStepID"
  static let numOfTimesBabyBreastFedStepID = "numOfTimesBabyBreastFedStepID"
  static let numOfTimesBabyExpressFedStepID = "numOfTimesBabyExpressFedStepID"
  static let numOfTimesBabyFormulaFedStepID = "numOfTimesBabyFormulaFedStepID"
}
