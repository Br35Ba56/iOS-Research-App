//
//  KeychainWrapperTests.swift
//  Breast Feeding NFPTests
//
//  Created by Anthony Schneider on 2/21/18.
//  Copyright © 2018 Anthony Schneider. All rights reserved.
//

import XCTest
import SwiftKeychainWrapper

class KeychainWrapperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKeychainSave() {
        let saveSuccessful: Bool = KeychainWrapper.standard.set("Some String", forKey: "myKey")
        XCTAssert(saveSuccessful)
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testKeychainRetrieve() {
        KeychainWrapper.standard.set("tonyschndr@gmail.com", forKey: "Username")
        KeychainWrapper.standard.set("Hendrix1!", forKey: "Password")

        let retrievedUsername: String? = KeychainWrapper.standard.string(forKey: "Username")
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "Password")
        XCTAssertEqual(retrievedUsername!, "tonyschndr@gmail.com")
        XCTAssertEqual(retrievedPassword!, "Hendrix1!")
    }
    
    func testKeychainRemove() {
        KeychainWrapper.standard.set("tonyschndr@gmail.com", forKey: "Username")
        KeychainWrapper.standard.set("Hendrix1!", forKey: "Password")
        
        let retrievedUsername: String? = KeychainWrapper.standard.string(forKey: "Username")
        let retrievedPassword: String? = KeychainWrapper.standard.string(forKey: "Password")
        
        XCTAssertEqual(retrievedUsername!, "tonyschndr@gmail.com")
        XCTAssertEqual(retrievedPassword!, "Hendrix1!")
        
        let removeUsernameSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "Username")
        let removePasswordSuccessful: Bool = KeychainWrapper.standard.removeObject(forKey: "Password")
        XCTAssert(removeUsernameSuccessful)
        XCTAssert(removePasswordSuccessful)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
