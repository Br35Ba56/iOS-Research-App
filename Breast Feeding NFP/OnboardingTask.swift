//
//  OnboardingTask.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/7/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit
import AWSCognito

class OnboardingTask : ORKNavigableOrderedTask {
  override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
    if (step?.identifier == "RegistrationStep") {
      if let stepResults = result.stepResult(forStepIdentifier: "RegistrationStep") {
        for result in stepResults.results as! [ORKResult] {
          if let questionResult = result as? ORKQuestionResult {
            if let stringResult = questionResult.answer {
              print(stringResult)
              //Once username and password are extracted, sign up via cognito, next step is verification
              
            }
          }
        }
      }
    }
    let nextStep = super.step(after: step, with: result)
    return nextStep
  }
}
