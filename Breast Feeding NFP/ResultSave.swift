//
//  ResultSave.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/14/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation
import AWSS3


class ResultSave {
  private var collector: ResultCollector!
  private let date: Date
  private var uuid: UUID
  private var surveyType: String!
  static private var resultSave: ResultSave!
  
  var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
  let transferUtility = AWSS3TransferUtility.default()
 
  
  private init(resultCollector: ResultCollector!, uuid: UUID!) {
    
    if let collector = resultCollector as? CycleTaskResult {
      self.collector = collector
      self.surveyType = "CycleTask"
    }
    if let collector = resultCollector as? OnboardingResults {
      self.collector = collector
      self.surveyType = "Onboarding"
    }
    if let collector = resultCollector as? DateTimeEntryResult {
      self.collector = collector
      self.surveyType = "BreastFeedingDateTime"
    }
    self.uuid = uuid
    self.date = Date()
  }
  
  static func saveResults(resultCollector: ResultCollector!, uuid: UUID!) {
    resultSave = ResultSave(resultCollector: resultCollector, uuid: uuid)
    let fileName = resultSave.surveyType + "_" + String(describing: Date()).replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: ":", with: "-") + String(describing: resultSave.uuid).replacingOccurrences(of: "+", with: "") + ".csv"
    let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
    do {
      try resultSave.collector.getEntryString().write(to: path!, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print(error.localizedDescription)
    }
    resultSave.uploadResults(path: path! as NSURL, fileName: fileName)
  }
  
  func uploadResults(path: NSURL, fileName: String) {
 
    let expression = AWSS3TransferUtilityUploadExpression()

    expression.setValue("AES256", forRequestParameter: "x-amz-server-side-encryption")
    print(expression.description)
    transferUtility.uploadFile(path as URL, bucket: "iosappbucket", key: ResultSave.getUserUUID() + "/" + surveyType + "/" + fileName, contentType: "file/csv", expression: expression, completionHandler: completionHandler).continueWith { (task) -> AnyObject! in
      if let error = task.error {
        print(error.localizedDescription)
      }
      if let _ = task.result {
        print("uploading started")
      }
      return nil;
    }
  }
  private static func getUserUUID() -> String {
    if let userUUID = UserDefaults.standard.object(forKey: "User UUID") {
      if let userUUIDString = userUUID as? String {
        return userUUIDString
      }
    }
    return ""
  }
}
/* bucket policy for encrypt
 {
 "Version": "2012-10-17",
 "Id": "PutObjPolicy",
 "Statement": [
 {
 "Sid": "DenyUnEncryptedObjectUploads",
 "Effect": "Deny",
 "Principal": "*",
 "Action": "s3:PutObject",
 "Resource": "arn:aws:s3:::iosappbucket/*",
 "Condition": {
 "StringNotEquals": {
 "s3:x-amz-server-side-encryption": "AES256"
 }
 }
 }
 ]
 }
 */*/
