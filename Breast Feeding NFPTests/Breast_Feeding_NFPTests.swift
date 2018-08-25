//
//  Breast_Feeding_NFPTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 8/24/17.
//  Copyright © 2017 Anthony Schneider. All rights reserved.
//

import XCTest
import AWSCore
@testable import Breast_Feeding_NFP

class Breast_Feeding_NFPTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCorrectRegion() {
      if AWSRegionType.USEast1 == AWSConstants.region {
        XCTAssert(true)
      } else {
        XCTAssert(false)
      }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
