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

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {
    

  @IBAction func joinAction(_ sender: Any) {
    
    //Age task
    let numericStyle = ORKNumericAnswerStyle.integer
    var numericFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "years", minimum: 18, maximum: 42)
    let ageQuestionStep = ORKQuestionStep(identifier: DemographicTask.ageQuestionID, title: DemographicTask.ageQuestionStepTitle, answer: numericFormat)
    ageQuestionStep.isOptional = false
    
    //Ethnicity
    let ethnicityTextChoice = [ORKTextChoice(text: "White or European-American", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Black or African American", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Native American or American Indian", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Asian / Pacific Islander", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Hispanic or Latino", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Some Other Race", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "I don't want to answer", value: 6 as NSCoding & NSCopying & NSObjectProtocol)]
    let ethnicityAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: ethnicityTextChoice)
    let ethnicityQuestionStep = ORKQuestionStep(identifier: DemographicTask.ethnicityQuestionID, title: DemographicTask.ethnicityQuestionStepTitle, answer: ethnicityAnswerFormat)
    
    //Level of education
    let educationTextChoice = [ORKTextChoice(text: "High School", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Associate Degree", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Bachelor Degree", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Master Degree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Doctorate Degree", value: 4 as NSCoding & NSCopying & NSObjectProtocol)]
    
    let levelOfEducationAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: educationTextChoice)
    let levelOfEducationQuestionStep = ORKQuestionStep(identifier: DemographicTask.levelOfEducationID, title: DemographicTask.levelOfEducationStepTitle, answer: levelOfEducationAnswerFormat)
    
    //Marital status task
    let maritalAnswerFormat: ORKBooleanAnswerFormat = ORKBooleanAnswerFormat(yesString: "Married", noString: "Single")
    let maritalQuestionStep = ORKQuestionStep(identifier: DemographicTask.maritalQuestionID, title: DemographicTask.maritalQuestionStepTitle, answer: maritalAnswerFormat)
    
    //How long married, skipped if participant is not married.
    let marriedNumericStyle = ORKNumericAnswerStyle.integer
    let marriedNumericFormat = ORKNumericAnswerFormat(style: marriedNumericStyle, unit: "years", minimum: 0, maximum: 35)
    let marriedLengthStep = ORKQuestionStep(identifier: DemographicTask.marriedLengthQuestionID, title: DemographicTask.marriedLengthStepTitle, answer: marriedNumericFormat)
    
    //How many children
    numericFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "quantity", minimum: 1, maximum: 10)
    let howManyChildrenStep = ORKQuestionStep(identifier: DemographicTask.howManyChildrenQuestionID, title: DemographicTask.howManyChildrenStepTitle, answer: numericFormat)
    
    //Child birth date
    let dateAnswerStyle = ORKDateAnswerStyle.date
    let userCalender = Calendar.current
    let minimumDate = userCalender.date(byAdding: .day, value: DemographicTask.minimumBirthDate, to: Date())
    let maximumDate = userCalender.date(byAdding: .day, value: DemographicTask.maximumBirthDate, to: Date())
    let childBirthDateAnswerFormat = ORKDateAnswerFormat(style: dateAnswerStyle, defaultDate: Date(), minimumDate: minimumDate!, maximumDate: maximumDate!, calendar: userCalender)
    let childBirthDateStep = ORKQuestionStep(identifier: DemographicTask.babysBirthDateQuestionID, title: DemographicTask.childBirthDateStepTitle, answer: childBirthDateAnswerFormat)
    childBirthDateStep.text = "Enter your childs birth date."
    childBirthDateStep.isOptional = false
    
    let clearBlueMonitorAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let clearBlueMonitorStep = ORKQuestionStep(identifier: DemographicTask.clearBlueMonitorQuestionID, title: DemographicTask.clearBlueMonitorTitle, answer: clearBlueMonitorAnswerFormat)
    clearBlueMonitorStep.isOptional = false
    
    let consentDocument = ConsentDocument()
    let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    
    
    let signature = consentDocument.signatures!.first!
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Review the consent form."
    reviewConsentStep.reasonForConsent = "Consent to join the Natural Family Planning Breast Feeding Study."
    
    let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
    passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
    
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome aboard."
    completionStep.text = "Thank you for joining this study."
    
    let orderedTask = ORKNavigableOrderedTask(identifier: "Join", steps: [
      ageQuestionStep,
      ethnicityQuestionStep,
      levelOfEducationQuestionStep,
      maritalQuestionStep,
      marriedLengthStep,
      childBirthDateStep,
      clearBlueMonitorStep,
      howManyChildrenStep,
      consentStep,
      reviewConsentStep,
      passcodeStep,
      completionStep])
    
    let resultSelector = ORKResultSelector(resultIdentifier: DemographicTask.maritalQuestionID)
    let predicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    let rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate, DemographicTask.babysBirthDateQuestionID)])
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: DemographicTask.maritalQuestionID)
    
    let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
    taskViewController.delegate = self
    
    present(taskViewController, animated: true, completion: nil)
  
  }

}

extension OnboardingViewController: ORKTaskViewControllerDelegate {
  public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    switch reason {
    case .completed:
      performSegue(withIdentifier: "unwindToStudy", sender: nil)
      
    case .discarded, .failed, .saved:
      dismiss(animated: true, completion: nil)
    }
  }
  
}

//
//  DemographicTask.swift
//  BreastFeeding
//
//  Created by Anthony Schneider on 7/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

struct DemographicTask {
  static let demographicTaskID = "Demographics Task"
  
  //Participants age question.
  static let ageQuestionID = "Age Question Step"
  static let ageQuestionStepTitle = "What is your age?"
  
  //Ethnicity question
  static let ethnicityQuestionID = "Ethnicity Question Step"
  static let ethnicityQuestionStepTitle = "What race do you consider yourself to be?"
  
  //Level of education question
  static let levelOfEducationID = "Level Of Education"
  static let levelOfEducationStepTitle = "What is your highest level of education completed?"
  
  //Marital status question
  static let maritalQuestionID = "Marital Question"
  static let maritalQuestionStepTitle = "What is your marital status?"
  
  //Married length question
  static let marriedLengthQuestionID = "Married Length Question"
  static let marriedLengthStepTitle = "How long have you been married?"
  
  //Number of children question
  static let howManyChildrenQuestionID = "How Many Children"
  static let howManyChildrenStepTitle = "How many children do you have?"
  
  
  //Baby's age question
  static let babysBirthDateQuestionID = "Baby Birth Date"
  static let childBirthDateStepTitle = "How old is your baby?"
  static let minimumBirthDate = -56 //Days
  static let maximumBirthDate = -42
  
  //CBM question
  static let clearBlueMonitorQuestionID = "CBM Question"
  static let clearBlueMonitorTitle = "Do you own a clear blue monitor?"
}
