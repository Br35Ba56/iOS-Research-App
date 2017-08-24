//
//  ResearchContainerViewController.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import UIKit
import ResearchKit

class ResearchContainerViewController: UIViewController {
  
  
  //MARK: Properties
  var contentHidden = false {
    didSet {
      guard contentHidden != oldValue && isViewLoaded else { return }
      childViewControllers.first?.view.isHidden = contentHidden
    }
  }
  
  //MARK: UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
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
    toWithdrawl()
  }
  
  //MARK: Transitions
  func toOnboarding() {
    performSegue(withIdentifier: "toOnboarding", sender: self)
  }
  
  func toStudy() {
    performSegue(withIdentifier: "toStudy", sender: self)
  }
  
  func toWithdrawl() {
    let viewController = WithdrawViewController()
    viewController.delegate = self
    present(viewController, animated: true, completion: nil)
  }
  
}

extension ResearchContainerViewController: ORKTaskViewControllerDelegate {
  public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    if taskViewController is WithdrawViewController {
      /*
       User withdrew from the study,
       
       */
      if reason == .completed {
        ORKPasscodeViewController.removePasscodeFromKeychain()
        toOnboarding()
      }
    dismiss(animated: true, completion: nil)
    }
  
  }
  
  
}
