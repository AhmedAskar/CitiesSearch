//
//  CitiesViewModelTest.swift
//  SearchCitiesTests
//
//  Created by Ahmed Askar on 9/16/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import XCTest
@testable import SearchCities

class CitiesViewModelTest: XCTestCase {
    
    var viewModelTest: CitiesViewModel!
    var cityService: MockCityService!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cityService = MockCityService()
        viewModelTest = CitiesViewModel(cityService: cityService)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cityService = nil
        viewModelTest = nil
        super.tearDown()
    }
    
    func testLoadCities() {
        cityService.completeCities = [City]()
        viewModelTest.loadCities(text: "text")
        XCTAssert(cityService!.isLoadCityCalled)
    }
    
    func testSearchCity() {
        cityService.completeCities = [City]()
        viewModelTest.findCities(result: ListResult.all)
        XCTAssert(cityService!.isLoadCityCalled)
    }
    
    func testSearchWithText() {
        let cities = StubGenerator().stubCities()
        let citiesTrie = CitiesTrie()
        for city in cities {
            citiesTrie.insert(city: city)
        }
        let searchCities = citiesTrie.find(prefix: "ya")
        XCTAssertTrue(searchCities.count > 1)
        XCTAssertNotEqual(searchCities[0].name, "Yawata")
        XCTAssertEqual(searchCities[0].name, "Yaamba")
    }
}

extension CitiesViewModelTest {
    private func loadCitiesFinished() {
        cityService.completeCities = StubGenerator().stubCities()
        viewModelTest.loadCities(text: "text")
        cityService.fetchSuccess()
    }
}

class MockCityService: CityServiceProtocol {
    
    var isLoadCityCalled = false
    
    var completeCities: [City] = [City]()
    var completeClosure: (([City]?, String?) -> ())!
    
    func loadCities(prefix char: String, complete: @escaping ([City]?, String?) -> ()) {
        isLoadCityCalled = true
        completeClosure = complete
    }
    
    func fetchSuccess() {
        completeClosure(completeCities, nil)
    }
    
    func fetchFail(error: String) {
        completeClosure(completeCities, error)
    }
}

class StubGenerator {
    func stubCities() -> [City] {
        let path = Bundle.main.path(forResource: "y", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let cities = try! JSONDecoder().decode(Array<City>.self, from: data)
        return cities
    }
}



