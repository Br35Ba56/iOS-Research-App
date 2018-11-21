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
import AWSCognitoIdentityProvider
import SwiftKeychainWrapper
import ResearchKit

class ProfileViewController: UIViewController {
  var indicatingView: UIActivityIndicatorView!
  
  @IBAction func signOutAction(_ sender: Any) {
    let pool = AWSCognitoIdentityUserPool.init(forKey: "UserPool")
    let user = pool.getUser()
    user.signOut()
    KeychainWrapper.standard.removeObject(forKey: "Password")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    indicatingView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    self.view.addSubview(indicatingView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func withdrawAction(_ sender: Any) {
    toWithdrawl()
  }
  
  func toWithdrawl() {
    let viewController = WithdrawViewController()
    viewController.delegate = self
    present(viewController, animated: true, completion: nil)
  }
}
extension ProfileViewController: ORKTaskViewControllerDelegate {
  public func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
    taskViewController.currentStepViewController?.taskViewController?.navigationBar.tintColor = UIColor(red: 0, green: 0.2, blue: 0.4, alpha: 1.0)
    
    taskViewController.currentStepViewController?.taskViewController?.view.tintColor = UIColor(red: 0, green: 0.2, blue: 0.4, alpha: 1.0)
  }
  public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    if taskViewController is WithdrawViewController {
     
      if reason == .completed {
        
        ORKPasscodeViewController.removePasscodeFromKeychain()
        let client = MUNFPBreastFeedingAPIClient.default()
        let disableUser = MUCognitouser()
        //TODO: Need to get user name.
        disableUser?.username = "tonyschndr@gmail.com"
        disableUser?.userpool = AWSConstants.poolID
        indicatingView?.startAnimating()
        client.cognitoDisableuserPost(body: disableUser!).continueWith {(task: AWSTask) -> AnyObject? in
          self.showResult(task: task)
          
          //Call toOnboarding in main thread
          DispatchQueue.main.async {
            self.indicatingView?.stopAnimating()
            let containerViewController = UIApplication.shared.keyWindow!.rootViewController as! ResearchContainerViewController
            containerViewController.toOnboarding()
           
          }
          
          return nil
        }
        //toOnboarding()
      }
      dismiss(animated: true, completion: nil)
    }
  }
  func showResult(task: AWSTask<AnyObject>) {
    print(task.description)
    if let error = task.error {
      print("Error: \(error)")
    } else if let result = task.result {
      let res = result as! NSDictionary
      print("NSDictionary: \(res)")
    }
  }
}

