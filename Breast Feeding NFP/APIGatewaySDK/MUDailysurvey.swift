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
public class MUDailysurvey : AWSModel {
    
    var clearBlueMonitor: String!
    var date: String!
    var menstruation: String!
    var progesterone: String!
    var numOfTimesBabyFormulaFed: String!
    var numOfTimesBabyExpressFed: String!
    var experienceBleeding: String!
    var numOfTimesBabyBreastFed: String!
    var userName: String!
    var type: String!
  

  
  func setValues(dailyResults: DailyTaskResults) {
    for result in dailyResults.results {
      
      switch result.key {
      case "clearBlueMonitor" :
        clearBlueMonitor = result.value
      case "date":
        date = result.value
      case "menstruation":
        menstruation = result.value
      case "progesterone":
        progesterone = result.value
      case "numOfTimesBabyFormulaFed":
        numOfTimesBabyFormulaFed = result.value
      case "numOfTimesBabyExpressFed":
        numOfTimesBabyExpressFed = result.value
      case "numOfTimesBabyBreastFed":
        numOfTimesBabyBreastFed = result.value
      case "experienceBleeding":
        experienceBleeding = result.value
      case "userName":
        userName = result.value
      case "type":
        type = result.value
      default:
        break
      }
    }
  }
  public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["clearBlueMonitor"] = "clearBlueMonitor"
		params["date"] = "date"
		params["menstruation"] = "menstruation"
		params["progesterone"] = "progesterone"
		params["numOfTimesBabyFormulaFed"] = "numOfTimesBabyFormulaFed"
		params["numOfTimesBabyExpressFed"] = "numOfTimesBabyExpressFed"
		params["experienceBleeding"] = "experienceBleeding"
		params["numOfTimesBabyBreastFed"] = "numOfTimesBabyBreastFed"
		params["userName"] = "userName"
		params["type"] = "type"
		
        return params
	}
}
