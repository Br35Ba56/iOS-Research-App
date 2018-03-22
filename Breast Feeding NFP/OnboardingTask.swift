//
//  OnboardingTask.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/7/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit
import AWSCognitoIdentityProvider
import SwiftKeychainWrapper


class OnboardingTask : ORKNavigableOrderedTask {
  var pool = AWSCognitoIdentityUserPool.init(forKey: "UserPool")
  override func step(after step: ORKStep?, with result: ORKTaskResult) -> ORKStep? {
    if (step?.identifier == "RegistrationStep") {
      var email = ""
      var password = ""
      var phoneNumber = ""
      if let stepResults = result.stepResult(forStepIdentifier: "RegistrationStep") {
        for result in stepResults.results as! [ORKResult] {
          if let questionResult = result as? ORKQuestionResult {
            if let stringResult = questionResult.answer {
              if questionResult.identifier == ORKRegistrationFormItemIdentifierEmail {
                email = stringResult as! String
              }
              if questionResult.identifier == ORKRegistrationFormItemIdentifierPassword {
                password = stringResult as! String
              }
              if questionResult.identifier == ORKRegistrationFormItemIdentifierPhoneNumber {
                phoneNumber = stringResult as! String
              }
            }
          }
          if !email.isEmpty && !password.isEmpty && !phoneNumber.isEmpty {
            signUpUser(email: email, password: password, phoneNumber: phoneNumber)
          }
        }
      }
    }
   
    let nextStep = super.step(after: step, with: result)
    return nextStep
  }
  
  private func signUpUser(email: String, password: String, phoneNumber: String) {
    var attributes = [AWSCognitoIdentityUserAttributeType]()
    let emailAttribute = AWSCognitoIdentityUserAttributeType()
    emailAttribute?.name = "email"
    emailAttribute?.value = email
    attributes.append(emailAttribute!)
    let phoneNumberAttribute = AWSCognitoIdentityUserAttributeType()
    phoneNumberAttribute?.name = "phone_number"
    phoneNumberAttribute?.value = phoneNumber
    attributes.append(phoneNumberAttribute!)
    
    self.pool.signUp(email, password: password, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
      guard let strongSelf = self else {
        print("No user pool?")
        return nil
      }
      DispatchQueue.main.async(execute: {
        if let error = task.error as NSError? {
          print("ERROR")
          print(error.description)
        } else if let result = task.result {
          if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
            AppDelegate.user = result.user
            KeychainWrapper.standard.set(result.user.username!, forKey: "Username")
            KeychainWrapper.standard.set(password, forKey: "Password")
          }
        }
      })
      return nil
    }
  }
}
