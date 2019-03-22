/*
 Copyright 2010-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 
 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at
 
 http://aws.amazon.com/apache2.0
 
 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */


import Foundation
import AWSCore


@objcMembers
public class MUOnboardingsurvey : AWSModel {
  
  var clearBlueMonitor: String!
  var date: String!
  var momHealth: String!
  var breastPumpInfo: String!
  var levelOfEducation: String!
  var howManyTimesPregnant: String!
  var ethnicity: String!
  var userName: String?
  var type: String?
  var participantAgeInRange: String!
  var biologicalInfant: String!
  var howLongInPastBreastFed: String!
  var biologicalSex: String!
  var breastSurgery: String!
  var canReadEnglish: String!
  var marriedLength: String?
  var babyFeedOnDemand: String!
  var infantAgeInRange: String!
  var babyBirthDate: String!
  var babyFullTerm: String!
  var howManyChildrenBreastFed: String!
  
  func setValues(onboardingResults: OnboardingTaskResults) {
    for result in onboardingResults.results {
      
      switch result.key {
      case "userName":
        userName = result.value
      case "date":
        date = result.value
      case "type":
        type = result.value
      case "clearBlueMonitor":
        clearBlueMonitor = result.value
      case "momHealth":
        momHealth = result.value
      case "breastPumpInfo":
        breastPumpInfo = result.value
      case "levelOfEducation":
        levelOfEducation = result.value
      case "howManyTimesPregnant":
        howManyTimesPregnant = result.value
      case "ethnicity":
        ethnicity = result.value
      case "participantAgeInRange":
        participantAgeInRange = result.value
      case "biologicalInfant":
        biologicalInfant = result.value
      case "howLongInPastBreastFed":
        howLongInPastBreastFed = result.value
      case "biologicalSex":
        biologicalSex = result.value
      case "breastSurgery":
        breastSurgery = result.value
      case "canReadEnglish":
        canReadEnglish = result.value
      case "marriedLength":
        marriedLength = result.value
      case "babyFeedOnDemand":
        babyFeedOnDemand = result.value
      case "infantAgeInRange":
        infantAgeInRange = result.value
      case "babyBirthDate":
        babyBirthDate = result.value
      case "babyFullTerm":
        babyFullTerm = result.value
      case "howManyChildrenBreastFed":
        howManyChildrenBreastFed = result.value
      default:
        break
      }
    }
  }
  
  public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
    var params:[AnyHashable : Any] = [:]
    params["clearBlueMonitor"] = "clearBlueMonitor"
    params["date"] = "date"
    params["momHealth"] = "momHealth"
    params["breastPumpInfo"] = "breastPumpInfo"
    params["levelOfEducation"] = "levelOfEducation"
    params["howManyTimesPregnant"] = "howManyTimesPregnant"
    params["ethnicity"] = "ethnicity"
    params["userName"] = "userName"
    params["type"] = "type"
    params["participantAgeInRange"] = "participantAgeInRange"
    params["biologicalInfant"] = "biologicalInfant"
    params["howLongInPastBreastFed"] = "howLongInPastBreastFed"
    params["biologicalSex"] = "biologicalSex"
    params["breastSurgery"] = "breastSurgery"
    params["canReadEnglish"] = "canReadEnglish"
    params["marriedLength"] = "marriedLength"
    params["babyFeedOnDemand"] = "babyFeedOnDemand"
    params["infantAgeInRange"] = "infantAgeInRange"
    params["babyBirthDate"] = "babyBirthDate"
    params["babyFullTerm"] = "babyFullTerm"
    params["howManyChildrenBreastFed"] = "howManyChildrenBreastFed"
    
    return params
  }
}
