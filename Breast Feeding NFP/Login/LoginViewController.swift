//
//  LoginViewController.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 2/23/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import ResearchKit
import SwiftKeychainWrapper

class LoginViewController: ORKLoginStepViewController {
  
  var user: AWSCognitoIdentityUser?
  var pool: AWSCognitoIdentityUserPool? = AWSCognitoIdentityUserPool(forKey: "UserPool")
  @IBOutlet var loginView: UIView!
  
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var password: UITextField!
  
  var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  override init(step: ORKStep, result: ORKResult) {
    super.init(step: step, result: result)
  }
  
  override init(step: ORKStep?) {
    super.init(step: step)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  @objc func stepDidChange() {
    guard step != nil && isViewLoaded else {
      return
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stepDidChange()
    if let  userName = KeychainWrapper.standard.string(forKey: "Username") {
      self.username.text = userName
    }
    if let password = KeychainWrapper.standard.string(forKey: "Password") {
      self.password.text = password
    }
    if (self.user == nil) {
      self.user = self.pool?.currentUser()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func forgotPasswordAction(_ sender: Any) {
    forgotPasswordButtonTapped()
  }
  @IBAction func signInButtonAction(_ sender: Any) {
    signIn()
  }
  
  override func forgotPasswordButtonTapped() {
    user?.forgotPassword()
  }
  
  func getUserName() -> String {
    var userName = self.username.text?.lowercased()
    userName = userName?.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines))
    return userName!
  }
  
  func signIn() {
    if (!getUserName().isEmpty && self.password.text != nil) {
      user?.getSession(getUserName(), password: password.text!, validationData: nil).continueWith(executor: AWSExecutor.mainThread(), block: {
        (task:AWSTask!) -> AnyObject? in
        if task.error == nil {
          if KeychainWrapper.standard.string(forKey: "Username") == nil {
            KeychainWrapper.standard.set(self.username.text!, forKey: "Username")
          }
          
          if KeychainWrapper.standard.string(forKey: "Password") == nil {
            KeychainWrapper.standard.set(self.password.text!, forKey: "Password")
          }
          AppDelegate.idToken = task.result?.idToken?.tokenString
          self.goForward()
        } else {
          print(task.error.debugDescription)
        }
        return nil
      }).continueWith(block: {
        (task:AWSTask!) -> AnyObject? in
        if let error = task.error {
          print(error)
        }
        return task
      })
    } else {
      let alertController = UIAlertController(title: "Missing information",
                                              message: "Please enter a valid user name and password",
                                              preferredStyle: .alert)
      let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
      alertController.addAction(retryAction)
    }
  }
}
extension LoginViewController: AWSCognitoIdentityPasswordAuthentication {
  func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
    print("AWSCognitoIdentiyPasswordAuthentication LoginViewController")
  }
  
  func didCompleteStepWithError(_ error: Error?) {
    
  }
  
  
}
class LoginViewControllerView: UIView {
  var loginViewControllerView: UIView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  private func commonInit() {
    Bundle.main.loadNibNamed("LoginViewController", owner: self, options: nil)
    addSubview(loginViewControllerView)
    loginViewControllerView.frame = self.bounds
    loginViewControllerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
}
