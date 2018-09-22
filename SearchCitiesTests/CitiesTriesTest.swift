//
//  CitiesTriesTest.swift
//  SearchCitiesTests
//
//  Created by Ahmed Askar on 9/16/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import XCTest
@testable import SearchCities

class CitiesTriesTest: XCTestCase {
    
    var citiesArray: [City]?
    var trie = CitiesTrie()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        testCreateCitiesArray()
        testInsertCitiesIntoTrie()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        citiesArray = nil
        super.tearDown()
    }
    
    func testCreateCitiesArray() {
        guard citiesArray == nil else {
            return
        }
        
        var data: Data?
        do {
            let path = Bundle.main.path(forResource: "y", ofType: "json")!
            data = try! Data(contentsOf: URL(fileURLWithPath: path))

        }
//        catch {
//            XCTAssertNil(error)
//        }
        
        XCTAssertNotNil(data)
        citiesArray = try! JSONDecoder().decode(Array<City>.self, from: data!)
        
        XCTAssertEqual(citiesArray?.count, 1778)
    }
    
    func testCreateCitiesArrayFail() {
        guard citiesArray == nil else {
            return
        }
        
        var data: Data?
        
        do {
            let path = Bundle.main.path(forResource: "@", ofType: "json")
            data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        }
//        catch {
//            XCTAssertNil(error)
//        }
        
        XCTAssertNotNil(data)
        citiesArray = try! JSONDecoder().decode(Array<City>.self, from: data!)
        
        XCTAssertEqual(citiesArray?.count, 1778)
    }
    
    func testInsertCitiesIntoTrie() {
        guard let citiesArray = citiesArray else { return }
        for city in citiesArray {
            trie.insert(city: city)
        }
    }
  
    func testInsert() {
        let trie = CitiesTrie()
        trie.insert(city: City(_id: 1, country: "EG", name: "Alex", coord: Coord(lat: 1.0997457, lon: 1.0997457)))
        trie.insert(city: City(_id: 2, country: "EG", name: "Albas", coord: Coord(lat: 1.0997457, lon: 1.0997457)))
        trie.insert(city: City(_id: 3, country: "EG", name: "Cairo", coord: Coord(lat: 1.1997457, lon: 1.1997457)))
        trie.insert(city: City(_id: 4, country: "EG", name: "Camhamada", coord: Coord(lat: 1.1997457, lon: 1.1997457)))
        trie.insert(city: City(_id: 5, country: "ES", name: "Barcelona", coord: Coord(lat: 1.1997457, lon: 1.1997457)))
        trie.insert(city: City(_id: 6, country: "US", name: "California", coord: Coord(lat: 1.1997457, lon: 1.1997457)))
        
        // Case 1
        let cities1 = trie.find(prefix: "al")
        XCTAssertTrue(cities1.count > 0)
        XCTAssertEqual(cities1.count, 2)
        
        // Case 2
        let cities2 = trie.find(prefix: "cai")
        XCTAssertEqual(cities2.count, 1)
        XCTAssertEqual(cities2[0].name, "Cairo")
        
        // Case 3
        let cities3 = trie.find(prefix: "ca")
        XCTAssertEqual(cities3.count, 3)
        
        // Case 4
        let cities4 = trie.find(prefix: "fa")
        XCTAssertFalse(cities4.count > 1)
    }
    
    // MARK: Test performance
    
    func testInsertPerformance() {
        self.measure {
            let trie = CitiesTrie()
            for city in self.citiesArray! {
                trie.insert(city: city)
            }
        }
    }
    
    func testSearchPerformance() {
        self.measure {
            let cities = trie.find(prefix: "yl")
            XCTAssertTrue(cities.count > 1)
        }
    }
    
}
