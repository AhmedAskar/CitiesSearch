//
//  CityServiceTest.swift
//  SearchCitiesTests
//
//  Created by Ahmed Askar on 9/16/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import XCTest
@testable import SearchCities

class CityServiceTest: XCTestCase {
    
    var cityServiceTest: CityService?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cityServiceTest = CityService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cityServiceTest = nil
        super.tearDown()
    }
    
    func testLoadCities() {
        
        // Given A apiservice
        let testService = self.cityServiceTest!
        
        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        
        testService.loadCities(prefix: "a") { (cities, error) in
            expect.fulfill()
            if let cities = cities {
                XCTAssertEqual(cities.count, 11206)
                for city in cities {
                    XCTAssertNotNil(city._id)
                }
            }
        }
        
        wait(for: [expect], timeout: 3.1)
    }
}
