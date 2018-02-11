//
//  PasscodeTask.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/10/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

struct PasscodeTask {
  
  static let passcodeTask: ORKOrderedTask = {
    let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
    passcodeStep.text = "Please create a passcode to protect access to information you enter"
    let orderedTask = ORKOrderedTask(identifier: "PasscodeTask", steps: [passcodeStep])
    return orderedTask
  }()
  
}
