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
import AWSCognitoIdentityProvider

class ResearchContainerViewController: UIViewController {
  
  //MARK: Properties
  var contentHidden = false {
    didSet {
      guard contentHidden != oldValue && isViewLoaded else { return }
      childViewControllers.first?.view.isHidden = contentHidden
    }
  }
  override func loadView(){
    super.loadView()
    
  }
  //MARK: UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    //UIView.appearance(whenContainedInInstancesOf: [ORKTaskViewController.self]).tintColor = UIColor(red: 1, green: 0.8, blue: 0.0, alpha: 1.0)
    
    if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
      toStudy()
    } else {
      toOnboarding()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
  }
  
  //MARK: segues
  @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
    toStudy()
  }
  
  @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
   // toWithdrawl()
  }
  
  @IBAction func unwindForSignOut(segue: UIStoryboardSegue) {
    let pool = AWSCognitoIdentityUserPool.init(forKey: "UserPool")
    pool.getUser().signOut()
    toOnboarding()
  }
  
  func toLoginOrSignup() {
    performSegue(withIdentifier: "toOnboarding", sender: self)
  }
  //MARK: Transitions
  func toOnboarding() {
    performSegue(withIdentifier: "toOnboarding", sender: self)
  }
  
  func toStudy() {
    performSegue(withIdentifier: "toStudy", sender: self)
  }
  
  /*func toWithdrawl() {
    let viewController = WithdrawViewController()
    //viewController.delegate = self
    present(viewController, animated: true, completion: nil)
  }*/
}