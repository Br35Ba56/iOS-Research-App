//
//  VerificationStep.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/8/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import ResearchKit
import AWSCognitoIdentityProvider

import SwiftKeychainWrapper

class VerificationStepViewController : ORKVerificationStepViewController {
  
  var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
  var user: AWSCognitoIdentityUser?
  var verificationCode: String?
  
  @IBOutlet var verificationStepView: UIView!
  @IBOutlet var verificationCodeTextField: UITextField!
  @IBOutlet var submitButton: UIButton!
  
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
  
  override func setupConstraints() {
    /*
     *Override function from ORKVerificationStepViewController
     *that crashes app when loading from nib
     */
  }
  
  @IBAction func submitVerificationCode(_ sender: Any) {
    if verificationCodeTextField.text != nil {
      user = AppDelegate.user
      verificationCode = verificationCodeTextField.text?.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines))
      
      verifyCode(verificationCode: verificationCode!)
    }
  }
  func verifyCode(verificationCode: String?) {
    guard let confirmationCodeValue = verificationCode, !confirmationCodeValue.isEmpty else {
      let alertController = UIAlertController(title: "Confirmation code missing.",
                                              message: "Please enter a valid confirmation code.",
                                              preferredStyle: .alert)
      let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertController.addAction(okAction)
      
      self.present(alertController, animated: true, completion:  nil)
      return
    }
    self.user?.confirmSignUp(verificationCode!, forceAliasCreation: true).continueWith {[weak self] (task: AWSTask) -> AnyObject? in
      guard let strongSelf = self else { return nil }
      DispatchQueue.main.async(execute: {
        if let error = task.error as NSError? {
          let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                  message: error.userInfo["message"] as? String,
                                                  preferredStyle: .alert)
          let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
          alertController.addAction(okAction)
          
          strongSelf.present(alertController, animated: true, completion:  nil)
        } else {
          self?.goForward()
        }
      })
      return nil
    }
  }
  
  
  @IBAction func resendVerificationCode(_ sender: Any) {
    resendEmailButtonTapped()
  }
  
  override func resendEmailButtonTapped() {
    self.user?.resendConfirmationCode()
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
