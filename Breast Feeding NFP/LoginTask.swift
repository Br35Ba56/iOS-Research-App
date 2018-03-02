//
//  LoginTask.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/10/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

struct LoginStep {
  static let loginTaskID = "LoginTask"
  
  static let loginTask: ORKOrderedTask = {
    let loginStep = ORKLoginStep(identifier: "LoginStep", title: "Log in", text: "Enter your credentials to log in", loginViewControllerClass: LoginViewController.self)
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
    passcodeStep.text = ("Please create a passcode to identify yourself to the app and protect access to information you've entered.")
    completionStep.title = "Welcome Back"
    let orderedTask = ORKOrderedTask(identifier: LoginStep.loginTaskID, steps: [
      loginStep,
      passcodeStep,
      completionStep])
    return orderedTask
  }()
}
