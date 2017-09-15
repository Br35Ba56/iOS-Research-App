//
//  ResultSave.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 9/14/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import Foundation

class ResultSave {
  private var collector: ResultCollector!
  private let date: Date
  private var uuid: UUID
  private var surveyType: String!
  
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
    let resultSave = ResultSave(resultCollector: resultCollector, uuid: uuid)
    let fileName = resultSave.surveyType + "_" + String(describing: Date()).replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "+", with: "").replacingOccurrences(of: ":", with: "-") + String(describing: resultSave.uuid).replacingOccurrences(of: "+", with: "") + ".csv"
    let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
    do {
      try resultSave.collector.getEntryString().write(to: path!, atomically: true, encoding: String.Encoding.utf8)
    } catch {
      print(error.localizedDescription)
    }
    print(String(describing: path))
    do {
      let contents = try String(contentsOf: path!)
      print(contents)
    } catch {
      print(error.localizedDescription)
    }
  }
}
