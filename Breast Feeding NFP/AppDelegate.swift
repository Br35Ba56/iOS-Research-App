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

import UIKit
import ResearchKit
import AWSCore
import AWSS3
import AWSCognitoIdentityProvider
import AWSCognito
import AWSMobileAnalytics
import SwiftKeychainWrapper

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var identityManager: AWSIdentityProviderManager?
  static var user: AWSCognitoIdentityUser?
  var loginViewController: LoginViewController?
  var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
  
  var window: UIWindow?
  
  var containerViewController: ResearchContainerViewController? {
    return window?.rootViewController as? ResearchContainerViewController
  }
  
  func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
    /*
     Store the completion handler.
     */
    AWSS3TransferUtility.interceptApplication(application, handleEventsForBackgroundURLSession: identifier, completionHandler: completionHandler)
  }
  
  func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    /*let standardDefaults = UserDefaults.standard
    if standardDefaults.object(forKey: "ORKSampleFirstRun") == nil {
      ORKPasscodeViewController.removePasscodeFromKeychain()
      standardDefaults.setValue("ORKSampleFirstRun", forKey: "ORKSampleFirstRun")
    }*/
    return true
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    lockApp()
    setUpAWSServices()
    if checkForUser() == false {
      print("No user signed in.  AppDelegate")
      self.containerViewController?.toLoginOrSignup()
    } else {
      print("User Signed in.  AppDelegate")
    }
    return true
  }
  
  func checkForUser() -> Bool {
    let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
    if (pool.currentUser()?.isSignedIn)! {
      guard let username = KeychainWrapper.standard.string(forKey: "Username"), let password = KeychainWrapper.standard.string(forKey: "Password") else {return false}
      pool.currentUser()?.getSession(username, password: password, validationData: nil)
      return true
    }
    return false
  }
  
  func setUpAWSServices() {
    AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
    AWSDDLog.sharedInstance.logLevel = .info
    
    //Cognito User Pools/Identity
    let serviceConfiguration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: nil)
    let userPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: AWSConstants.appClientID, clientSecret: AWSConstants.appClientSecret, poolId: AWSConstants.poolID)
    AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: userPoolConfiguration, forKey: "UserPool")
    let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
    let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1, identityPoolId: AWSConstants.identityPoolID, identityProviderManager:pool)
    AWSServiceManager.default().defaultServiceConfiguration = AWSServiceConfiguration(region: .USEast1, credentialsProvider: credentialsProvider)
    
    AWSS3TransferUtility.register(with: AWSServiceManager.default().defaultServiceConfiguration!, forKey: "TransferUtility")
  
    AWSMobileAnalytics.init(forAppId: AWSConstants.mobileAnalyticsAppID, configuration: AWSMobileAnalyticsConfiguration.init())
    CognitoSync.synchronizeDataSet()
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
      // Hide content so it doesn't appear in the app switcher.
      containerViewController?.contentHidden = true
    }
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    lockApp()
  }
 
  func lockApp() {
    /*
     Only lock the app if there is a stored passcode and a passcode
     controller isn't already being shown.
     */
  
    guard ORKPasscodeViewController.isPasscodeStoredInKeychain() && !(containerViewController?.presentedViewController is ORKPasscodeViewController) else { return }
    
    window?.makeKeyAndVisible()
  
    let passcodeViewController = ORKPasscodeViewController.passcodeAuthenticationViewController(withText: "Welcome back to the Natural Family Planning Breastfeeding Research Study", delegate: self)
    containerViewController?.present(passcodeViewController, animated: false, completion: nil)
  }
}

extension AppDelegate: ORKPasscodeDelegate {
  func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
    containerViewController?.contentHidden = false
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    //TODO:  What happens if user forgets passcode????
    //Should challenge them to Cognito log in then reset passcode after authentication with cognito
    
  }
}




// MARK:- AWSCognitoIdentityRememberDevice protocol delegate
extension AppDelegate: AWSCognitoIdentityRememberDevice {
  
  func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
    self.rememberDeviceCompletionSource = rememberDeviceCompletionSource
    DispatchQueue.main.async {
      // dismiss the view controller being present before asking to remember device
      self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
      let alertController = UIAlertController(title: "Remember Device",
                                              message: "Do you want to remember this device?.",
                                              preferredStyle: .actionSheet)
      
      let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
        self.rememberDeviceCompletionSource?.set(result: true)
      })
      let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
        self.rememberDeviceCompletionSource?.set(result: false)
      })
      alertController.addAction(yesAction)
      alertController.addAction(noAction)
      
      self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
  }
  
  func didCompleteStepWithError(_ error: Error?) {
    DispatchQueue.main.async {
      if let error = error as NSError? {
        let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                message: error.userInfo["message"] as? String,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
          self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
      }
    }
  }
}
