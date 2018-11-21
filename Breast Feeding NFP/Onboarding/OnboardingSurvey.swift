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

struct Onboarding {
  static let taskID = "OnboardingTaskID"
  private static let boolAnswerFormat = ORKBooleanAnswerFormat(yesString: "Yes", noString: "No")
  
  static let onboardingSurvey: OnboardingTask = {
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

    let orderedTask = OnboardingTask(identifier: Onboarding.taskID, steps: [
      //TODO: DELETE - Moved for debugging
      registrationStep,
      verificationStep,
      //Eligibility
      biologicalSexStep,
      biologicalInfantStep,
      singletonBirthStep,
      babyBornFullTermStep,
      participantAgeInRangeStep,
      momHealthStep,
      breastSurgeryStep,
      infantAgeInRangeStep,
      clearBlueMonitorStep,
      canReadEnglishStep,
      
      //Consent Document
      consentStep,
      reviewConsentStep,
      
      //Demographic
      participantBirthDateStep,
      babysBirthDateStep,
      babyFeedOnDemandStep,
      breastPumpInfoStep,
      ethnicityStep,
      religionStep,
      levelOfEducationStep,
      relationshipStatusStep,
      marriedLengthStep,
      howManyTimesPregnant,
      howManyBiologicalChildren,
      howManyChildrenBreastFedStep,
      howLongInPastBreastFedStep,
      registrationInstructionStep,
      //TODO: Uncomment after debugging
      //registrationStep,
      //verificationStep,
      loginStep,
      passcodeStep,
      completionStep,
      ineligibleStep])
    
    //Mark: Ineligible Predicates
    var resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.biologicalInfantStepID)
    let biologicalInfantPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.singletonBirthStepID)
    let singletonBirthPredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.babyBornFullTermStep)
    let babyBornFullTermPredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.momHealthStepID)
    let momHealthPredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.breastSurgeryStepID)
    let breastSurgeryPredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.participantAgeInRangeStepID)
    let participantAgeInRangePredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.infantAgeInRangeStepID)
    let infantAgeInRangePredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.clearBlueMonitorStepID)
    let clearBlueMonitorPredicate =  ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.canReadEnglishStepID)
    let canReadEnglishPredicate = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: false)
    
    //Mark: Demographic Predicates
    resultSelector = ORKResultSelector(resultIdentifier: DemographicSteps.relationshipStatusID)
    let relationshipStatusPredicateOne = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 1 as NSCoding & NSCopying & NSObjectProtocol)
    let relationshipStatusPredicateTwo = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 2 as NSCoding & NSCopying & NSObjectProtocol)
    let relationshipStatusPredicateThree =  ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 3 as NSCoding & NSCopying & NSObjectProtocol)
    let relationshipStatusPredicateFour =  ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 4 as NSCoding & NSCopying & NSObjectProtocol)
    let relationshipStatusPredicateFive =  ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 5 as NSCoding & NSCopying & NSObjectProtocol)
    
    resultSelector = ORKResultSelector(resultIdentifier: EligibilitySteps.biologicalSexStepID)
    let biologicalSexPredicateMale = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 1 as NSCoding & NSCopying & NSObjectProtocol)
    let biologicalSexPredicateOther = ORKResultPredicate.predicateForChoiceQuestionResult(with: resultSelector, expectedAnswerValue: 2 as NSCoding & NSCopying & NSObjectProtocol)

    //Mark: Navigation Rules
    let rule = ORKPredicateStepNavigationRule(resultPredicatesAndDestinationStepIdentifiers: [(biologicalSexPredicateMale, EligibilitySteps.ineligibleStepID),
                                                                                              (biologicalSexPredicateOther, EligibilitySteps.ineligibleStepID),
                                                                                              (biologicalInfantPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (singletonBirthPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (babyBornFullTermPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (momHealthPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (breastSurgeryPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (participantAgeInRangePredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (infantAgeInRangePredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (clearBlueMonitorPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (canReadEnglishPredicate, EligibilitySteps.ineligibleStepID),
                                                                                              (relationshipStatusPredicateOne, DemographicSteps.howManyBiologicalChildrenStepID),
                                                                                              (relationshipStatusPredicateTwo, DemographicSteps.howManyBiologicalChildrenStepID),
                                                                                              (relationshipStatusPredicateThree, DemographicSteps.howManyBiologicalChildrenStepID),
                                                                                              (relationshipStatusPredicateFour, DemographicSteps.howManyBiologicalChildrenStepID),
                                                                                              (relationshipStatusPredicateFive, DemographicSteps.howManyBiologicalChildrenStepID)])
    
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.biologicalInfantStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.singletonBirthStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.babyBornFullTermStep)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.momHealthStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.breastSurgeryStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.participantAgeInRangeStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.infantAgeInRangeStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.clearBlueMonitorStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.canReadEnglishStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: EligibilitySteps.biologicalSexStepID)
    orderedTask.setNavigationRule(rule, forTriggerStepIdentifier: DemographicSteps.relationshipStatusID)
    
    let directRule = ORKDirectStepNavigationRule(destinationStepIdentifier: ORKNullStepIdentifier)
    orderedTask.setNavigationRule(directRule, forTriggerStepIdentifier: "CompletionStep")
    return orderedTask
  }()
  
  private static let ineligibleStep: ORKStep = {
    let ineligibleStep = ORKInstructionStep(identifier: EligibilitySteps.ineligibleStepID)
    ineligibleStep.title = "Sorry"
    ineligibleStep.text = "We have determined your are ineligible for this study"
    return ineligibleStep
  }()
  
  //MARK: Eligibility Steps
  
  private static let biologicalSexStep: ORKStep = {
    let title = "Biological sex?"
    let textChoices = [ORKTextChoice(text: "Female", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Male", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "None of the above", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let biologicalSexStep = ORKQuestionStep(identifier: EligibilitySteps.biologicalSexStepID, title: title, question: "What is your biological sex?", answer: answerFormat)
    biologicalSexStep.isOptional = false
    return biologicalSexStep
  }()
  
  private static let biologicalInfantStep: ORKStep = {
    let title = "Breastfeeding Status"
    let question = "Are you breastfeeding your biological infant?"
    let biologicalInfantStep = ORKQuestionStep(identifier: EligibilitySteps.biologicalInfantStepID, title: title, question: question, answer: boolAnswerFormat)
    biologicalInfantStep.isOptional = false
    return biologicalInfantStep
  }()
  
  private static let singletonBirthStep: ORKStep = {
    let title = "Breastfeeding status"
    let question = "Are you breastfeeding a single infant?"
    let singletonBirthQuestionStep = ORKQuestionStep(identifier: EligibilitySteps.singletonBirthStepID, title: title, question: question , answer: boolAnswerFormat)
    singletonBirthQuestionStep.isOptional = false
    return singletonBirthQuestionStep
  }()
  
  private static let babyBornFullTermStep: ORKStep = {
    let title = "Baby's Birth"
    let question = "Was your baby born full-term(>/=37 weeks gestation)?"
    let babyBornFullTermQuestionStep = ORKQuestionStep(identifier: EligibilitySteps.babyBornFullTermStep, title: title, question: question, answer: boolAnswerFormat)
    babyBornFullTermQuestionStep.isOptional = false
    return babyBornFullTermQuestionStep
  }()
  
  private static let participantAgeInRangeStep: ORKStep = {
    let title = "Age"
    let question = "Are you between the ages of 18-42"
    let participantAgeStep = ORKQuestionStep(identifier: EligibilitySteps.participantAgeInRangeStepID, title: title, question: question, answer: boolAnswerFormat)
    participantAgeStep.isOptional = false
    return participantAgeStep
  }()
  
  private static let momHealthStep: ORKStep = {
    let title = "Mom's Health"
    let text = "Have you ever been diagnosed with Poly Cystic Ovarian Syndrome, Gestational Diabetes or Type 2 Diabetes Mellitus"
    let momHealthStep = ORKQuestionStep(identifier: EligibilitySteps.momHealthStepID, title: title, question: text, answer: boolAnswerFormat)
    momHealthStep.isOptional = false
    return momHealthStep
  }()
  
  private static let breastSurgeryStep: ORKStep = {
    let title = "Breast Surgery"
    let question = "Have you ever had surgery to change the size of your breasts?"
    let breastSurgeryStep = ORKQuestionStep(identifier: EligibilitySteps.breastSurgeryStepID, title: title, question: question, answer: boolAnswerFormat)
    breastSurgeryStep.isOptional = false
    return breastSurgeryStep
  }()
  
  private static let infantAgeInRangeStep: ORKStep = {
    let title = "Infant Age"
    let text = "Is your infant between 6 - 8 weeks of age?\nPlease email ___@email.com if your infant falls outside of this range so we can approve this by a case to case basis."
    
    let infantAgeInRangeStep = ORKQuestionStep(identifier: EligibilitySteps.infantAgeInRangeStepID, title: title, question: text, answer: boolAnswerFormat)
    infantAgeInRangeStep.isOptional = false
    return infantAgeInRangeStep
  }()
  
  private static let clearBlueMonitorStep: ORKStep = {
    let question = "Do you own a Clearblue Easy Fertility Monitor?\n(original or touchscreen)"
    let clearBlueMonitorStep = ORKQuestionStep(identifier: EligibilitySteps.clearBlueMonitorStepID, title: "Clearblue Monitor", question: question, answer: boolAnswerFormat)
    clearBlueMonitorStep.isOptional = false
    return clearBlueMonitorStep
  }()
  
  private static let canReadEnglishStep: ORKStep = {
    let question = "Are you comfortable reading and writing English on your phone?"
    //let canReadEnglishStep = ORKQuestionStep(identifier: EligibilitySteps.canReadEnglishStepID, title: title, answer: boolAnswerFormat)
    let canReadEnglishStep = ORKQuestionStep(identifier: EligibilitySteps.canReadEnglishStepID, title: "Language", question: question, answer: boolAnswerFormat)
    canReadEnglishStep.isOptional = false
    return canReadEnglishStep
  }()
  
  
  //MARK: Demographic Steps
  
  private static let participantBirthDateStep: ORKStep = {
    let title = "What is your birth date?"
    let dateAnswerStyle = ORKDateAnswerStyle.date
    let userCalander = Calendar.current
    let minimumDate = userCalander.date(byAdding: .year, value: -42, to: Date())
    let maximumDate = userCalander.date(byAdding: .year, value: -18, to: Date())
    let answerFormat = ORKDateAnswerFormat(style: dateAnswerStyle, defaultDate: minimumDate!, minimumDate: minimumDate, maximumDate: maximumDate, calendar: userCalander)
    let participantBirthDateStep = ORKQuestionStep(identifier: DemographicSteps.participantBirthDateStepID, title: title, answer: answerFormat)
    participantBirthDateStep.isOptional = false
    return participantBirthDateStep
  }()
  
  private static let babysBirthDateStep: ORKStep = {
    let title = "Baby's Age"
    let question = "How old is your baby?"
    let dateAnswerStyle = ORKDateAnswerStyle.date
    let userCalender = Calendar.current
    let minimumDate = userCalender.date(byAdding: .day, value: -63, to: Date())
    let maximumDate = userCalender.date(byAdding: .day, value: -35, to: Date())
    let answerFormat = ORKDateAnswerFormat(style: dateAnswerStyle, defaultDate: maximumDate!, minimumDate: minimumDate!, maximumDate: maximumDate!, calendar: userCalender)
    let childBirthDateStep = ORKQuestionStep(identifier: DemographicSteps.babysBirthDateStepID, title: title, question: question, answer: answerFormat)
    childBirthDateStep.isOptional = false
    
    return childBirthDateStep
  }()
  
  private static let babyFeedOnDemandStep: ORKStep = {
    let title = "Baby's Feeding Shedule"
    let question = "Does you baby feed on demand or on a schedule?"
    let textChoices = [ORKTextChoice(text: "On Demand", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "On Schedule", value: 1 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let babyFeedOnDemandStep = ORKQuestionStep(identifier: DemographicSteps.babyFeedOnDemandStepID, title: title, question: question, answer: answerFormat)
    babyFeedOnDemandStep.isOptional = false
    return babyFeedOnDemandStep
  }()
  
  private static let breastPumpInfoStep: ORKStep = {
    let title = "Breast Pump"
    let question = "Do you use a Breast Pump?\nIf so, what brand is it?"
    let answerFormat = ORKTextAnswerFormat(maximumLength: 30)
    let breastPumpInfoStep = ORKQuestionStep(identifier: DemographicSteps.breastPumpInfoStepID, title: title, question: question, answer: answerFormat)
    breastPumpInfoStep.isOptional = true
    return breastPumpInfoStep
  }()
  
  private static let ethnicityStep: ORKStep = {
    let title = "What race do you consider yourself to be?"
    let textChoices = [ORKTextChoice(text: "White or European-American", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Black or African American", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Native American or American Indian", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Asian / Pacific Islander", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Hispanic or Latino", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                               ORKTextChoice(text: "Some Other Race", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
                               ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let ethnicityQuestionStep = ORKQuestionStep(identifier: DemographicSteps.ethnicityStepID, title: title, answer: answerFormat)
    return ethnicityQuestionStep
  }()
  
  private static let religionStep: ORKStep = {
    let title = "What religion (if any) do you belong to or most closely identify with?"
    let textChoices = [ORKTextChoice(text: "Catholic", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Lutheran", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Methodist", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Baptist", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Jewish", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Muslim", value: 5 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "No Religion", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Other", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let ethnicityQuestionStep = ORKQuestionStep(identifier: DemographicSteps.religionStepID, title: title, answer: answerFormat)
    return ethnicityQuestionStep
  }()
  
  private static let levelOfEducationStep: ORKStep = {
    let title = "What is your highest level of education completed?"
    let textChoices = [ORKTextChoice(text: "High School or less", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Some college", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "College degree", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Postgraduate school", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let levelOfEducationStep = ORKQuestionStep(identifier: DemographicSteps.levelOfEducationStepID, title: title, answer: answerFormat)
    return levelOfEducationStep
  }()
  
  private static let relationshipStatusStep: ORKStep = {
    let title = "What is your relationship status?"
    let textChoices = [ORKTextChoice(text: "Married", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Not married, cohabitating", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "In a relationship, not cohabitating", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Single and not dating", value: 3 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Single and dating", value: 4 as NSCoding & NSCopying & NSObjectProtocol),
                       ORKTextChoice(text: "Other", value: 5 as NSCoding & NSCopying & NSObjectProtocol)
    ]
    let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: textChoices)
    let maritalStatusStep = ORKQuestionStep(identifier: DemographicSteps.relationshipStatusID, title: title, answer: answerFormat)
    maritalStatusStep.isOptional = false
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
  
  private static let howManyTimesPregnant: ORKStep = {
    let title = "How many times have you been pregnant?"
    let text = "Including miscarriages or abortions"
    let numericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "quantity", minimum: 1, maximum: 10)
    let howManyChildrenStep = ORKQuestionStep(identifier: DemographicSteps.howManyTimesPregnantStepID, title: title, answer: answerFormat)
    howManyChildrenStep.text = text
    return howManyChildrenStep
  }()
  
  private static let howManyBiologicalChildren: ORKStep = {
    let title = "How many biological children do you have?"
    let numericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "quantity", minimum: 1, maximum: 10)
    let howManyChildrenStep = ORKQuestionStep(identifier: DemographicSteps.howManyBiologicalChildrenStepID, title: title, answer: answerFormat)
    return howManyChildrenStep
  }()
  
  private static let howManyChildrenBreastFedStep: ORKStep = {
    let title = "How many children have you breastfed?"
    let numericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "quantity", minimum: 0, maximum: 10)
    let howManyChildrenBreastFedStep = ORKQuestionStep(identifier: DemographicSteps.howManyChildrenBreastFedStepID, title: title, answer: answerFormat)
    return howManyChildrenBreastFedStep
  }()
 
  private static let howLongInPastBreastFedStep: ORKStep = {
    let title = "How long in the past have you breastfed?"
    let numericStyle = ORKNumericAnswerStyle.integer
    let answerFormat = ORKNumericAnswerFormat(style: numericStyle, unit: "months", minimum: 0, maximum: 24)
    let howLongInPastBreastFedStep = ORKQuestionStep(identifier: DemographicSteps.howLongInPastBreastFedStepID, title: title, answer: answerFormat)
    return howLongInPastBreastFedStep
  }()
  
  //MARK: Registration Steps
  private static let registrationInstructionStep: ORKStep = {
    let registrationInstructionStep = ORKInstructionStep(identifier: "InstructionStep")
    registrationInstructionStep.title = "Registration"
    registrationInstructionStep.text = "In the next two steps you will register with our service and verify your account.  The verification code will be sent to the phone number you provide."
    return registrationInstructionStep
  }()
  
  private static let registrationStep: ORKStep = {
    let registrationStep = ORKRegistrationStep(identifier: "RegistrationStep", title: "Registration", text: "Register for an account to continue.", options: [ORKRegistrationStepOption.includePhoneNumber])
    registrationStep.passcodeValidationRegularExpression = try? NSRegularExpression(pattern: "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$^+=!*()@%&]).{8,16}$")
    registrationStep.passcodeInvalidMessage = "Password must be 8-16 characters long and contain atleast 1 upper character, 1 lower character, 1 number, and 1 special character"
    for item in registrationStep.formItems! {
      if item.identifier == ORKRegistrationFormItemIdentifierPhoneNumber {
        item.placeholder = "+15555555555"
      }
    }
    registrationStep.phoneNumberValidationRegularExpression = try! NSRegularExpression(pattern: "^[+][1][0-9]{10,10}$")
    registrationStep.phoneNumberInvalidMessage = "Invalid phone number\nFormat "
    return registrationStep
  }()
  
  private static let verificationStep: ORKStep = {
    let verificationStep = ORKVerificationStep(identifier: "VerificationStep", text: "Please verify the code sent to your email.", verificationViewControllerClass: VerificationStepViewController.self)
    return verificationStep
  }()
  
  private static let loginStep: ORKStep = {
    let loginStep = ORKLoginStep(identifier: "LoginStep", title: "Login", text: "Enter username and password", loginViewControllerClass: LoginViewController.self)
    return loginStep
  }()
}

//MARK: Step IDs
struct EligibilitySteps {
  static let biologicalSexStepID = "biologicalSexStepID"
  static let biologicalInfantStepID = "biologicalInfantStepID"
  static let singletonBirthStepID = "singletonBirthStepID"
  static let babyBornFullTermStep = "babyFullTermStepID"
  static let participantAgeInRangeStepID = "participantAgeInRangeStepID"
  static let momHealthStepID = "momHealthStepID"
  static let breastSurgeryStepID = "breastSurgeryStepID"
  static let infantAgeInRangeStepID = "infantAgeInRangeStepID"
  static let clearBlueMonitorStepID = "clearBlueMonitorStepID"
  static let canReadEnglishStepID = "canReadEnglishStepID"
  static let ineligibleStepID = "ineligibleStepID"
}

struct DemographicSteps {
  static let participantBirthDateStepID = "participantBirthDateStepID"
  static let babysBirthDateStepID = "babyBirthDateStepID"
  static let babyFeedOnDemandStepID = "babyFeedOnDemandStepID"
  static let breastPumpInfoStepID = "breastPumpInfoStepID"
  static let ethnicityStepID = "ethnicityStepID"
  static let religionStepID = "religionStepID"
  static let levelOfEducationStepID = "levelOfEducationStepID"
  static let relationshipStatusID = "relationshipStatusStepID"
  static let marriedLengthStepID = "marriedLengthStepID"
  static let howManyTimesPregnantStepID = "howManyTimesPregnantStepID"
  static let howManyBiologicalChildrenStepID = "howManyBiologicalChildrenStepID"
  static let howManyChildrenBreastFedStepID = "howManyChildrenBreastFedStepID"
  static let howLongInPastBreastFedStepID = "howLongInPastBreastFedStepID"
}
