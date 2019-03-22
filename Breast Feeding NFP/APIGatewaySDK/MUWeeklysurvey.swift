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
public class MUWeeklysurvey : AWSModel {
    
    var date: String!
    var usedAnyContraceptives: String!
    var didMenstruateThisWeek: String!
    var recentlyDiagnosed: String!
    var userName: String!
    var type: String!
    var stillBreastfeeding: String!
    var areYouPregnant: String!
  
  func setValues(weeklyResults: WeeklyTaskResults) {
    for result in weeklyResults.results {
      
      switch result.key {
      case "usedAnyContraceptives":
        usedAnyContraceptives = result.value
      case "didMenstruateThisWeek":
        didMenstruateThisWeek = result.value
      case "recentlyDiagnosed":
        recentlyDiagnosed = result.value
      case "userName":
        userName = result.value
      case "stillBreastfeeding":
        stillBreastfeeding = result.value
      case "areYouPregnant":
        areYouPregnant = result.value
      case "date":
        date = result.value
      case "type":
        type = result.value
      default:
        break
      }
    }
  }
  
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["date"] = "date"
		params["usedAnyContraceptives"] = "usedAnyContraceptives"
		params["didMenstruateThisWeek"] = "didMenstruateThisWeek"
		params["recentlyDiagnosed"] = "recentlyDiagnosed"
		params["userName"] = "userName"
		params["type"] = "type"
		params["stillBreastfeeding"] = "stillBreastfeeding"
		params["areYouPregnant"] = "areYouPregnant"
		
        return params
	}
}
