//
//  ResultSave.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/14/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import AWSS3
import SwiftKeychainWrapper

class ProcessResults {
  private var surveyTaskResults: TaskResults!
  private var uuid: UUID?
  private var surveyType: String!
  static private var processResults: ProcessResults!
  
  var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
  let transferUtility = AWSS3TransferUtility.s3TransferUtility(forKey: "TransferUtility")

  private init(taskResults: TaskResults!) {
    if let results = taskResults as? DailyTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "DailySurvey"
    }
    if let results = taskResults as? OnboardingTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "OnboardingSurvey"
    }
    if let results = taskResults as? WeeklyTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "WeeklySurvey"
    }
  }
  
  private init(taskResults: TaskResults!, uuid: UUID!) {
    print(taskResults.debugDescription)
    if let results = taskResults as? DailyTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "DailySurvey"
    }
    if let results = taskResults as? OnboardingTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "OnboardingSurvey"
    }
    if let results = taskResults as? WeeklyTaskResults {
      self.surveyTaskResults = results
      self.surveyType = "WeeklySurvey"
    }
    self.uuid = uuid
  }
  
  
  static func saveResultsToCoreData(taskResults: TaskResults!) {
      processResults = ProcessResults(taskResults: taskResults)
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      let entity = NSEntityDescription.entity(forEntityName: processResults.surveyType, in: managedContext)!
      let survey = NSManagedObject(entity: entity, insertInto: managedContext)
    
    for result in taskResults.results {
      survey.setValue(result.value, forKey: result.key)
      print("\(result.value)  \(result.key)")
    }
    survey.setValue(false, forKey: "uploaded")
      
     
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
   //   survey.setValue(self.results[DailyCycleSurvey.clearBlueMonitorStepID], forKey: DailyCycleSurvey.clearBlueMonitorStepID)
    
    
  }
  //TODO: saveResults and uploadResults should go directly to dynamodb table via APIGateway/Lambda
  //if upload to DynamoDB fails due to internet connection or other, save to core data and reattempt
  //upload at a later time.

  static func saveResults(taskResults: TaskResults!) {
    if taskResults is DailyTaskResults {
     
        let muDailyResult = MUDailysurvey.init(dictionary: taskResults.results)
      
   

    } else if taskResults is WeeklyTaskResults {
      
    } else if taskResults is OnboardingTaskResults {
      
    }
  }
  
  static func saveResults(taskResults: TaskResults!, uuid: UUID!) {
    processResults = ProcessResults(taskResults: taskResults, uuid: uuid)
    let fileName = String(describing: processResults.uuid) + ".json"
    let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
    
    do {
      try processResults.surveyTaskResults.getEntryJSON().write(to: path!, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print(error.localizedDescription)
    }
    processResults.uploadResults(path: path! as NSURL, fileName: fileName)
  }
  
  func uploadResults(path: NSURL, fileName: String) {
  
    let expression = AWSS3TransferUtilityUploadExpression()

    expression.setValue("AES256", forRequestParameter: "x-amz-server-side-encryption")
    transferUtility.uploadFile(path as URL, bucket: AWSConstants.bucket, key: ProcessResults.getUserName() + "/" + surveyType + "/" + fileName, contentType: "file/json", expression: expression, completionHandler: completionHandler).continueWith { (task) -> AnyObject? in
      if let error = task.error {
        print(error.localizedDescription)
      }
      if let _ = task.result {
        print("uploading started")
      }
      return nil;
    }
  }
  
 
  
  private static func getUserName() -> String {
    if let userName = KeychainWrapper.standard.string(forKey: "Username") {
      return userName
    }
    return "Unkown User"
  }
}

