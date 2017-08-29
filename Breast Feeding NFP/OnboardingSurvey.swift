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

import Foundation
import ResearchKit
//TODO:  Add predicates once order has been verified
struct Onboarding {
  private static let boolAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
  
  static let onboardingSurvey: ORKNavigableOrderedTask = {
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
      biologicalInfantStep,
      singletonBirthStep,
      babyHealthStep,
      momHealthStep,
      breastSurgeryStep, 
      participantAgeInRangeStep,
      infantAgeInRangeStep,
      clearBlueMonitorStep,
      consentStep,
      reviewConsentStep,
      participantBirthDateStep,
      childBirthDateStep,
      ethnicityQuestionStep,
      levelOfEducationStep,
      maritalStatusStep,
      marriedLengthStep,
      howManyChildrenStep,
      passcodeStep,
      completionStep,
      ineligibleStep])
    
    //Build predicates to direct to ineligible page.
    var resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.biologicalInfantStepID)
    let predicate1 = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.singletonBirthStepID)
    let predicate2 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.babyHealthStepID)
    let predicate3 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.momHealthStepID)
    let predicate4 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.breastSurgeryStepID)
    let predicate5 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.participantAgeInRangeStepID)
    let predicate6 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.infantAgeInRangeStepID)
    let predicate7 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.clearBlueMonitorStepID)
    let predicate8 =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: DemographicSteps.maritalStatusStepID)
    let predicate9 = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    


    let rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(predicate1, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate2, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate3, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate4, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate5, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate6, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate7, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate8, EligibilitySteps.ineligibleStepID),
                                                                                              (predicate9, DemographicSteps.howManyChildrenStepID)])
    
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.biologicalInfantStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.singletonBirthStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.babyHealthStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.momHealthStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.breastSurgeryStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.participantAgeInRangeStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.infantAgeInRangeStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.clearBlueMonitorStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: DemographicSteps.maritalStatusStepID)
    
    
    let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    orderedTask.setNavigationRule(directRule, forTriggerStepIdentifier: "CompletionStep")
    return orderedTask
  }()
  
  private static let ineligibleStep: ORKStep = {
    let ineligibleStep = ORKInstructionStep(identifier: EligibilitySteps.ineligibleStepID)
    ineligibleStep.title = "Were sorry, we have determined your are ineligible for this study"
    
    return ineligibleStep
  }()
  
  private static let biologicalInfantStep: ORKStep = {
    let title = "Are you breastfeeding your biological infant?"
    let biologicalInfantStep = ORKQuestionStep(identifier: EligibilitySteps.biologicalInfantStepID, title: title, answer: boolAnswerFormat)
    biologicalInfantStep.isOptional = false
    return biologicalInfantStep
  }()
  
  private static let singletonBirthStep: ORKStep = {
    let singletonBirthQuestionStepTitle = "Are you only breastfeeding a single infant?"
    let singletonBirthQuestionStep = ORKQuestionStep(identifier: EligibilitySteps.singletonBirthStepID, title: singletonBirthQuestionStepTitle, answer: boolAnswerFormat)
    singletonBirthQuestionStep.isOptional = false
    return singletonBirthQuestionStep
  }()
  
  private static let babyHealthStep: ORKStep = {
    let title = "Is your baby healthy?"
    let babyHealthStep = ORKQuestionStep(identifier: EligibilitySteps.babyHealthStepID, title: title, answer: boolAnswerFormat)
    babyHealthStep.isOptional = false
    return babyHealthStep
  }()
  
  private static let momHealthStep: ORKStep = {
    let title = "Have you been diagnosed with any of the following?"
    let text = "Polycystic Ovarian Syndrome or Breast Augmentation"
    let momHealthStep = ORKQuestionStep(identifier: EligibilitySteps.momHealthStepID, title: title, text: text, answer: boolAnswerFormat)
    momHealthStep.isOptional = false
    return momHealthStep
  }()
  
  private static let breastSurgeryStep: ORKStep = {
    let title = "Have you ever had your breasts enlarged or decreased in size?"
    let breastSurgeryStep = ORKQuestionStep(identifier: EligibilitySteps.breastSurgeryStepID, title: title, answer: boolAnswerFormat)
    breastSurgeryStep.isOptional = false
    return breastSurgeryStep
  }()
  
  private static let clearBlueMonitorStep: ORKStep = {
    let title = "Do you own a Clearblue Easy Fertility Monitor?"
    let clearBlueMonitorStep = ORKQuestionStep(identifier: EligibilitySteps.clearBlueMonitorStepID, title: title, answer: boolAnswerFormat)
    clearBlueMonitorStep.isOptional = false
    return clearBlueMonitorStep
  }()
  
  private static let participantAgeInRangeStep: ORKStep = {
    let title = "Are you between the ages of 18-42"
    let participantAgeStep = ORKQuestionStep(identifier:  EligibilitySteps.participantAgeInRangeStepID, title: title, answer: boolAnswerFormat)
    participantAgeStep.isOptional = false
    return participantAgeStep
  }()
  
  private static let infantAgeInRangeStep: ORKStep = {
    let title = "Is your infant between 6 - 8 weeks of age?"
    let text = "Please email ___@email.com if your infant falls outside of this range so we can approve this by a case to case basis."
    let answerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
    let infantAgeInRangeStep = ORKQuestionStep(identifier: EligibilitySteps.infantAgeInRangeStepID, title: title, text: text, answer: answerFormat)
    infantAgeInRangeStep.isOptional = false
    return infantAgeInRangeStep
  }()
  
  private static let participantBirthDateStep: ORKStep = {
    let title = "What is your birth date?"
    let dateAnswerStyle = ORKDateAnswerStyle.date
    let userCalander = Calendar.current
    let minimumDate = userCalander.date(byAdding: .year, value: -42, to: Date())
    let maximumDate = userCalander.date(byAdding: .year, value: -18, to: Date())
    let answerFormat = ORKDateAnswerFormat(style: dateAnswerStyle, defaultDate: Date(), minimumDate: minimumDate, maximumDate: maximumDate, calendar: userCalander)
    let participantBirthDateStep = ORKQuestionStep(identifier: DemographicSteps.participantBirthDateStepID, title: title, answer: answerFormat)
    participantBirthDateStep.isOptional = false
    return participantBirthDateStep
  }()
  
  private static let childBirthDateStep: ORKStep = {
    let title = "How old is your baby?"
    let dateAnswerStyle = ORKDateAnswerStyle.date
    let userCalender = Calendar.current
    let minimumDate = userCalender.date(byAdding: .day, value: -63, to: Date())
    let maximumDate = userCalender.date(byAdding: .day, value: -35, to: Date())
    let answerFormat = ORKDateAnswerFormat(style: dateAnswerStyle, defaultDate: Date(), minimumDate: minimumDate!, maximumDate: maximumDate!, calendar: userCalender)
    let childBirthDateStep = ORKQuestionStep(identifier: DemographicSteps.babysBirthDateStepID, title: title, answer: answerFormat)
    childBirthDateStep.isOptional = false
    return childBirthDateStep
  }()
  
  private static let ethnicityQuestionStep: ORKStep = {
    let title = "What race do you consider yourself to be?"
    let textChoices = [ORKTextChoice(text: "White or European-American", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Black or African American", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Native American or American Indian", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Asian / Pacific Islander", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Hispanic or Latino", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Some Other Race", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "I don't want to answer", value: 6 as NSCoding & NSCopying & NSObjectProtocol)]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let ethnicityQuestionStep = ORKQuestionStep(identifier: DemographicSteps.ethnicityStepID, title: title, answer: answerFormat)
    return ethnicityQuestionStep
  }()
  
  private static let levelOfEducationStep: ORKStep = {
    let title = "What is your highest level of education completed?"
    let textChoices = [ORKTextChoice(text: "High School", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Associate Degree", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Bachelor Degree", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Master Degree", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Doctorate Degree", value: 4 as NSCoding & NSCopying & NSObjectProtocol)]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let levelOfEducationStep = ORKQuestionStep(identifier: DemographicSteps.levelOfEducationStepID, title: title, answer: answerFormat)
    return levelOfEducationStep
  }()

  
  private static let maritalStatusStep: ORKStep = {
    let title = "What is your marital status?"
    let answerFormat: ORKBooleanAnswerFormat = ORKBooleanAnswerFormat(yesString: "Married", noString: "Single")
    let maritalStatusStep = ORKQuestionStep(identifier: DemographicSteps.maritalStatusStepID, title: title, answer: answerFormat)
    return maritalStatusStep
  }()
  
  private static let marriedLengthStep: ORKStep = {
    //How long married, skipped if participant is not married.
    let title = "How long have you been married?"
    let marriedNumericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: marriedNumericStyle, unit: "years", minimum: 0, maximum: 35)
    let marriedLengthStep = ORKQuestionStep(identifier: DemographicSteps.marriedLengthStepID, title: title, answer: answerFormat)
    return marriedLengthStep
  }()
  
  private static let howManyChildrenStep: ORKStep = {
    let title = "How many children do you have?"
    let numericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "quantity", minimum: 1, maximum: 10)
    let howManyChildrenStep = ORKQuestionStep(identifier: DemographicSteps.howManyChildrenStepID, title: "How many children do you have?", answer: answerFormat)
    return howManyChildrenStep
  }()

}

struct EligibilitySteps {
  static let biologicalInfantStepID = "biologicalInfantStepID"
  static let infantAgeInRangeStepID = "infantAgeInRangeStepID"
  static let clearBlueMonitorStepID = "clearBlueMonitorStepID"
  static let participantAgeInRangeStepID = "participantAgeInRangeStepID"
  static let singletonBirthStepID = "singletonBirthStepID"
  static let babyHealthStepID = "babyHealthID"
  static let momHealthStepID = "momHealthStepID"
  static let breastSurgeryStepID = "breastSurgeryStepID"
  static let ineligibleStepID = "ineligibleStepID"

}

struct DemographicSteps {
  static let demographicTaskID = "demographicTaskID"
  static let participantBirthDateStepID = "participantBirthDateStepID"
  static let ethnicityStepID = "ethnicityStepID"
  static let levelOfEducationStepID = "levelOfEducationID"
  static let maritalStatusStepID = "maritalStepID"
  static let marriedLengthStepID = "marriedLengthStepID"
  static let babysBirthDateStepID = "babyBirthDateStepID"
  static let howManyChildrenStepID = "howManyChildrenStepID"
}
