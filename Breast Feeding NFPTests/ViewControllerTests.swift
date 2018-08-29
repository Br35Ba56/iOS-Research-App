//
//  ViewControllerTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 8/26/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest
@testable import Breast_Feeding_NFP
import ResearchKit
class ViewControllerTests: XCTestCase {
  private var rootViewController: ActivityViewController!
 
  private var topLevelUIUtilities: TopLevelUIUtilities<ActivityViewController>!
  

  override func setUp() {
    super.setUp()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let myViewController = storyboard.instantiateViewController(withIdentifier: "ActivityViewController") as! ActivityViewController
    rootViewController = myViewController
    topLevelUIUtilities = TopLevelUIUtilities<ActivityViewController>()
    topLevelUIUtilities.setupTopLevelUI(withViewController: rootViewController)
  }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  func testORKResult() {
   
  }
  
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
