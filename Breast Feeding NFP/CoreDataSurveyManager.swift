//
//  CoreDataSurveyManager.swift
//  Breast Feeding NFP
//
//  Created by Anthony Schneider on 12/29/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import Foundation

class CoreDataSurveyManager {
  let appDelegate: AppDelegate!
  let context: NSManagedObjectContext!
  
  init() {
    appDelegate = UIApplication.shared.delegate as? AppDelegate
    context = appDelegate.persistentContainer.viewContext
  }
  
  func checkForUploadedFalseSurveys() {
    
  }
  
  func deleteUploadedSurvey(taskResult: TaskResults) {
    let date = taskResult.results["date"]
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: taskResult.results["type"]!)
    request.predicate = NSPredicate(format: "date == %@", date!)
    request.returnsObjectsAsFaults = false
    do {
      if let result = try context.fetch(request) as? [NSManagedObject] {
        if result.count == 1 {
          print("deleteUploadedSurveys() result == 1")
          let survey = result[0]
          context.delete(survey)
          try context.save()
        } else {
          print("More than one object with that date")
        }
      }
    } catch {
      print("Error deleting object")
    }
  }
  
  func checkForOnboardingSurvey() -> Bool {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "OnboardingSurvey")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      if result.count == 1 {
        let onboardingSurvey = result[0] as! OnboardingSurvey
        let onboardingTaskResult = OnboardingTaskResults()
        onboardingTaskResult.enterTaskResult(onboardingSurvey: onboardingSurvey)
        ProcessResults.saveResultsFromCoreData(taskResults: onboardingTaskResult)
      }
    } catch {
      print("Error uploading saved onboarding survey from core data")
    }
    return true
  }
  func checkForWeeklySurveys() {
    
  }
  
  func checkForDailySurveys() {
    
  }
  
  func saveCoreDataState() {
    
  }
  
}
