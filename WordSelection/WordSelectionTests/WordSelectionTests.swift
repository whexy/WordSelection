//
//  WordSelectionTests.swift
//  WordSelectionTests
//
//  Created by shiwx on 9/12/21.
//

import XCTest
@testable import WordSelection

class WordSelectionTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testToWordlist() throws {
        let sens = "Whexy and his friends, if there's any, are going to play <Overwatch> tonight."
        let wordlist = WordSelection.toWordlist(sentence: sens)
        print(wordlist)
    }
}
