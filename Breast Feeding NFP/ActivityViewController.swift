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

class ActivityViewController: UITableViewController {
  //var taskResults: CycleTaskResult? = CycleTaskResult()
  
  // MARK: UITableViewDataSource
  
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
    return cell
  }
  
  // MARK: UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let activity = Activity(rawValue: (indexPath as NSIndexPath).row) else { return }
    let taskViewController: ORKTaskViewController
    switch activity {
    case .survey:
      
      taskViewController = ORKTaskViewController(task: StudyTasks.dailySurveyTask, taskRun: NSUUID() as UUID)
    case .breastfeedingManual:
      taskViewController = ORKTaskViewController(task: StudyTasks.manualBreastFeedTask, taskRun: NSUUID() as UUID)
      taskViewController.showsProgressInNavigationBar = false
      /*do {
       let defaultFileManager = FileManager.default
       
       // Identify the documents directory.
       let documentsDirectory = try defaultFileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
       
       // Create a directory based on the `taskRunUUID` to store output from the task.
       let outputDirectory = documentsDirectory.appendingPathComponent(taskViewController.taskRunUUID.uuidString)
       try defaultFileManager.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
       
       taskViewController.outputDirectory = outputDirectory
       }
       catch let error as NSError {
       fatalError("The output directory for the task with UUID: \(taskViewController.taskRunUUID.uuidString) could not be created. Error: \(error.localizedDescription)")
       }*/
      
    }
    taskViewController.delegate = self
    navigationController?.present(taskViewController, animated: true, completion: nil)
  }
}

extension ActivityViewController : ORKTaskViewControllerDelegate {
  
  func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
    
    switch reason {
    case .completed:
      var resultCollector: ResultCollector?
      if taskViewController.task!.identifier == DailyCycleSurvey.taskID {
        resultCollector = CycleTaskResult()
      } else if taskViewController.task!.identifier == DateTimeSurvey.taskID {
        resultCollector = DateTimeEntryResult()
      }
      if let results = taskViewController.result.results as? [ORKStepResult] {
        for stepResult: ORKStepResult in results {
          for result in stepResult.results! {
            if let questionResult = result as? ORKChoiceQuestionResult {
              let anotherResult = questionResult.answer as! NSObject
              let stringResult = StringFormatter.buildString(stepResultString: anotherResult.description)
              resultCollector?.enterTaskResult(identifier: questionResult.identifier, result: stringResult)
            }
            if let questionResult = result as? ORKBooleanQuestionResult {
              if let finalResult = questionResult.booleanAnswer?.intValue {
                print(questionResult.identifier)
                resultCollector?.enterTaskResult(identifier: questionResult.identifier, result: finalResult.description)
              }
            }
            if let questionResult = result as? ORKDateQuestionResult {
              if let finalResult = questionResult.dateAnswer {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                let dateString = dateFormatter.string(from: finalResult)
                
                resultCollector?.enterTaskResult(identifier: questionResult.identifier, result: dateString)
              }
            }
            else {
              //TODO: Remove
              print("No printable results.")
            }
          }
        }
        ResultSave.saveResults(resultCollector: resultCollector, uuid: taskViewController.taskRunUUID)
      }
    default: break
    }
    taskViewController.dismiss(animated: true, completion: nil)
  }
}


