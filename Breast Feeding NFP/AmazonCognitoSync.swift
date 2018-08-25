//
//  AmazonCognitoSync.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 3/11/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation
import AWSCognito

struct CognitoSync {
  
  public static func synchronizeDataSet() {
    let cognitoSync = AWSCognito.default()
    let dataSet = cognitoSync.openOrCreateDataset("weeklyTaskDataSet")
    dataSet.synchronize().continueWith(block: {(task)->AnyObject? in
      if task.isCancelled {
        
      } else if task.error != nil {
        print("Error syncing.")
        print(task.error.debugDescription)
      } else {
        print("Data was saved")
      }
      return task
    })
  }
}
