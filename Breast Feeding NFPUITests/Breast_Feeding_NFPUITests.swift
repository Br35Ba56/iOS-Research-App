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
      
      let tablesQuery2 = app.tables
      let tablesQuery = tablesQuery2
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Female"]/*[[".cells[\"Female\"].staticTexts[\"Female\"]",".staticTexts[\"Female\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      let noStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells[\"No\"].staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      noStaticText.tap()
      noStaticText.tap()
      app.navigationBars["UIPageView"].buttons["Back"].tap()
      
      let yesStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells[\"Yes\"].staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      yesStaticText.tap()
      tablesQuery2.buttons["Next"].tap()
      print(app.debugDescription)
      
  
      
      /*
      let app = XCUIApplication()
      let key = app/*@START_MENU_TOKEN@*/.keys["0"]/*[[".keyboards.keys[\"0\"]",".keys[\"0\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      key.tap()
      key.tap()
      key.tap()
      key.tap()
      
      let tablesQuery = app.tables
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Daily Survey"]/*[[".cells.staticTexts[\"Daily Survey\"]",".staticTexts[\"Daily Survey\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      let elementsQuery = app.scrollViews.otherElements
      elementsQuery.buttons["Get Started"].tap()
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Not Taken"]/*[[".cells[\"Not Taken\"].staticTexts[\"Not Taken\"]",".staticTexts[\"Not Taken\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Not taken"]/*[[".cells[\"Not taken\"].staticTexts[\"Not taken\"]",".staticTexts[\"Not taken\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["No"]/*[[".cells[\"No\"].staticTexts[\"No\"]",".staticTexts[\"No\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      elementsQuery.buttons["Next"].tap()
      
      let textField = elementsQuery.cells.children(matching: .textField).element
      textField.tap()
      
      let key2 = app/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      key2.tap()
      
      let nextButton = app/*@START_MENU_TOKEN@*/.buttons["Next"]/*[[".scrollViews.buttons[\"Next\"]",".buttons[\"Next\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      nextButton.tap()
      textField.tap()
      
      let key3 = app/*@START_MENU_TOKEN@*/.keys["6"]/*[[".keyboards.keys[\"6\"]",".keys[\"6\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      key3.tap()
      
      nextButton.tap()
      textField.tap()
      key2.tap()
      nextButton.tap()
      
      app.tables.buttons["Next"].tap()
      app.navigationBars["UIPageView"].buttons["Done"].tap()
       
       let app = XCUIApplication()
       app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).buttons["Join Study"].tap()
       
       let tablesQuery = app.tables
       tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Female"]/*[[".cells[\"Female\"].staticTexts[\"Female\"]",".staticTexts[\"Female\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
       
       let yesStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Yes"]/*[[".cells[\"Yes\"].staticTexts[\"Yes\"]",".staticTexts[\"Yes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
       yesStaticText.tap()
       yesStaticText.tap()
   */
    }
    
}
