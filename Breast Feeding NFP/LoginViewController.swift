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
import AWSUserPoolsSignIn

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
  
  func signIn() {
    if (self.username.text != nil && self.password.text != nil) {
      let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.username.text!, password: self.password.text! )
      
    
      user?.getSession(username.text!, password: password.text!, validationData: nil).continueWith(executor: AWSExecutor.mainThread(), block: {
        (task:AWSTask!) -> AnyObject! in
        
        if task.error == nil {
          print("No Error")
          print(task.result?.idToken?.tokenString)
          
          AWSServiceManager.default().defaultServiceConfiguration.credentialsProvider.credentials()
          self.goForward()
        } else {
          print("Some Error")
          print(task.error)
        }
        return nil
      }).continueWith(block: {
        (task:AWSTask!) -> AnyObject! in
        if let error = task.error {
          print("Auth Cred Errorr")
        }
        return task
      })
      print(AppDelegate.user?.isSignedIn)
 
    } else {
      let alertController = UIAlertController(title: "Missing information",
                                              message: "Please enter a valid user name and password",
                                              preferredStyle: .alert)
      let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
      alertController.addAction(retryAction)
    }
  }
  
  override func forgotPasswordButtonTapped() {
    print("Forgot password")
  }
  
  @IBAction func signInButtonAction(_ sender: Any) {
    signIn()
    //let session = AppDelegate.user?.getSession()
    //print(session.debugDescription)
  }
}
extension LoginViewController: AWSCognitoIdentityPasswordAuthentication {
  
  public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
    self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
    let debug = self.passwordAuthenticationCompletion.debugDescription
    print("Debug getDetails")
    print(debug)
  }
  
  public func didCompleteStepWithError(_ error: Error?) {
    print("IS ERROR FUNCTION RUNNING?")
    DispatchQueue.main.async {
      if let error = error as NSError? {
        let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                message: error.userInfo["message"] as? String,
                                                preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
        alertController.addAction(retryAction)
        
        self.present(alertController, animated: true, completion:  nil)
      } else {
        print("Success Signing In")
      }
    }
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
