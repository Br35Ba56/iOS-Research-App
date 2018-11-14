//
//  Breast_Feeding_NFPUITests.swift
//  Breast Feeding NFPUITests
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import XCTest

class Breast_Feeding_NFPUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDailySurveyUI() {
      
      let app = XCUIApplication()
      app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["Join Study"].tap()
      
      let tablesQuery = app.tables
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Female"]/*[[".cells[\"Female\"].staticTexts[\"Female\"]",".staticTexts[\"Female\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      var yesStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells[\"Yes\"].staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      yesStaticText.tap()
   
      
    }
    
}
