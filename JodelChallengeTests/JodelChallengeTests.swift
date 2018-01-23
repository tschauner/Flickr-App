//
//  JodelChallengeTests.swift
//  JodelChallengeTests
//
//  Created by Michal Ciurus on 21/09/2017.
//  Copyright © 2017 Jodel. All rights reserved.
//

import XCTest
@testable import JodelChallenge

class JodelChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testJSONMapping() {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "response", withExtension: "json") else {
            XCTFail("Missing file: User.json")
            return
        }
          let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data.init(contentsOf: url)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            let photos = try jsonDecoder.decode(FlickrPhoto.self, from: jsonData)
            
            XCTAssertEqual(photos.title, "Coding challenge")
            XCTAssertEqual(photos.secret, "12349")
            
        } catch let error {
            XCTFail(error.localizedDescription)
        }
 
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
