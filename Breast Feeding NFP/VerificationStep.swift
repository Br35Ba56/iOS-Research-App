//
//  VerificationStep.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/8/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit

/*class VerificationStep : ORKVerificationStep {
  
}*/

class VerificationStepViewController : ORKVerificationStepViewController {
  
  
  @IBOutlet var verificationStepView: UIView!
  @IBOutlet weak var verificationCodeTextField: UITextField!
  
  override init(step: ORKStep, result: ORKResult) {
    super.init(step: step, result: result)
  }
  
  override init(step: ORKStep?) {
    super.init(step: step)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stepDidChange()
  }
  
  @objc func stepDidChange() {
    guard step != nil && isViewLoaded else {
      return
    }
  }
  

  @IBAction func submitVerificationCode(_ sender: Any) {
    if let verificationCode = verificationCodeTextField.text {
      verifyCode(code: verificationCode)
     self.goForward()
    }
  }
  func verifyCode(code: String) {
    //AWS Cognito code to verify code.
    print("verifiyCode \(code)")
    
  }

  @IBAction func resendVerificationCode(_ sender: Any) {
    resendEmailButtonTapped()
  }
  
  
  override func resendEmailButtonTapped() {
    //AWS Cognito code to resend email verification
    print("Resent email")
  }
  

}

class VerificationStepView: UIView {
  var verificationStepView: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  private func commonInit() {
    Bundle.main.loadNibNamed("VerificationStepView", owner: self, options: nil)
    addSubview(verificationStepView)
    verificationStepView.frame = self.bounds
    verificationStepView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
