//
//  OnboardingViewController.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import UIKit
import ResearchKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  @IBAction func joinAction(_ sender: Any) {
    let consentDocument = ConsentDocument()
    let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    
    
    let signature = consentDocument.signatures!.first!
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
    
    reviewConsentStep.text = "Review the consent form."
    reviewConsentStep.reasonForConsent = "Consent to join the Developer Health Research Study."
    
    let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
    passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
    
    let completionStep = ORKCompletionStep(identifier: "CompletionStep")
    completionStep.title = "Welcome aboard."
    completionStep.text = "Thank you for joining this study."
    
    let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep, passcodeStep, completionStep])
    let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
    taskViewController.delegate = self
    
    present(taskViewController, animated: true, completion: nil)
  
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OnboardingViewController: ORKTaskViewControllerDelegate {
  public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    switch reason {
    case .completed:
      performSegue(withIdentifier: "unwindToStudy", sender: nil)
      
    case .discarded, .failed, .saved:
      dismiss(animated: true, completion: nil)
    }
  }
  
}
