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
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var identityManager: AWSIdentityProviderManager?
  static var user: AWSCognitoIdentityUser?
  var signInViewController: LoginViewController?
  var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
  static var idToken: String?
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
    return true
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    lockApp()
    setUpAWSServices()
    checkForCoreData()
    if checkForUser() == false {
      print("No user signed in.  AppDelegate")
      self.containerViewController?.toOnboarding()
    } else {
      print("User Signed in.  AppDelegate")
      self.containerViewController?.toStudy()
    }
   
    return true
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
  
  func checkForUser() -> Bool {
    let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
    if (pool.currentUser()?.isSignedIn)! {
      guard let username = KeychainWrapper.standard.string(forKey: "Username"), let password = KeychainWrapper.standard.string(forKey: "Password") else {return false}
      pool.currentUser()?.getSession(username, password: password, validationData: nil).continueWith {(task: AWSTask) -> AnyObject? in
        let result = task.result
        AppDelegate.idToken = result?.idToken?.tokenString
        return nil
      }
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
  
  static func getSessionKey() -> String {
    if idToken != nil {
      return idToken!
    }
    return ""
  }
  
  func checkForCoreData() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "DailySurvey")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      let dailySurveys = result as! [DailySurvey]
      for survey in dailySurveys {
        if survey.uploaded == false {
        
          print("upload surveys")
        } else {
          print("delete surveys")
        }
      }
      print("No surveys found")
      
    } catch {
      print("Error fetching daily survey")
    }
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "BreastFeedingNFPModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        
        /*
         Typical reasons for an error here include:
         * The parent directory does not exist, cannot be created, or disallows writing.
         * The persistent store is not accessible, due to permissions or data protection when the device is locked.
         * The device is out of space.
         * The store could not be migrated to the current model version.
         Check the error message to determine what the actual problem was.
         */
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Replace this implementation with code to handle the error appropriately.
        // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}

extension AppDelegate: ORKPasscodeDelegate {
  func passcodeViewControllerDidFinish(withSuccess viewController: UIViewController) {
    containerViewController?.contentHidden = false
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func passcodeViewControllerDidFailAuthentication(_ viewController: UIViewController) {
    //TODO:  What happens if user forgets passcode????
    //Should challenge them to Cognito log in then reset passcode after authentication with cognito?
  }
}


extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
  
  func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
    return self.signInViewController!
  }
  
  func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
    return self
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
