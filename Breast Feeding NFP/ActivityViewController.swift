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
import AWSCognito
import AWSCognitoIdentityProvider

class ActivityViewController: UITableViewController {
  
  // MARK: UITableViewDataSource
  override func viewWillAppear(_ animated: Bool) {
    print("View appeared")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("View did load")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard section == 0 else { return 0 }
    return Activity.allValues.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
    if let activity = Activity(rawValue: (indexPath as NSIndexPath).row) {
      cell.textLabel?.text = activity.title
      cell.detailTextLabel?.text = activity.subtitle
    }
    if indexPath.row == 1 {
      let cognitoSync = AWSCognito.default()
      let dataSet = cognitoSync.openOrCreateDataset("weeklyTaskDataSet")
      print("Row == 1")
      print(dataSet.string(forKey: "WeeklyTaskDate"))
      if let dateString = dataSet.string(forKey: "WeeklyTaskDate") {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateString)
        let timeInterval = date?.timeIntervalSince(Date())
        print("Time interval \(String(describing: timeInterval))")
      }
     
      cell.isUserInteractionEnabled = true
    }
    return cell
  }
  
  // MARK: UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let activity = Activity(rawValue: (indexPath as NSIndexPath).row) else { return }
    let taskViewController: ORKTaskViewController
    switch activity {
    case .dailySurvey:
      taskViewController = ORKTaskViewController(task: StudyTasks.dailySurveyTask, taskRun: NSUUID() as UUID)
    case .weeklySurvey:
      taskViewController = ORKTaskViewController(task: StudyTasks.weeklySurvey, taskRun: NSUUID() as UUID)
    case .withdrawSurvey:
      taskViewController = WithdrawViewController.init()
    }
    taskViewController.delegate = self
    navigationController?.present(taskViewController, animated: true, completion: nil)
  }
}

extension ActivityViewController : ORKTaskViewControllerDelegate {
  public func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
    taskViewController.currentStepViewController?.taskViewController?.navigationBar.tintColor = UIColor(red: 0, green: 0.2, blue: 0.4, alpha: 1.0)
    taskViewController.currentStepViewController?.taskViewController?.view?.tintColor = UIColor(red: 0, green: 0.2, blue: 0.4, alpha: 1.0)
  
  }
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    
    switch reason {
    case .completed:
      if taskViewController.task?.identifier == StudyTasks.weeklySurvey.identifier{
        let cognitoSync = AWSCognito.default()
        let dataSet = cognitoSync.openOrCreateDataset("weeklyTaskDataSet")
        let todaysDate = Date()
        print(todaysDate.description)
        dataSet.setString(todaysDate.description, forKey: "WeeklyTaskDate")
        dataSet.synchronize()
      }
      if taskViewController.task?.identifier == "Withdraw" {
        self.performSegue(withIdentifier: "unwindToOnboarding", sender: nil)
      }
      let taskResults = TaskViewControllerResults.getViewControllerResults(taskViewController: taskViewController)
      ProcessResults.saveResults(taskResults: taskResults, uuid: taskViewController.taskRunUUID)
      
    default: break
    }
    taskViewController.dismiss(animated: true, completion: nil)
  }
}


