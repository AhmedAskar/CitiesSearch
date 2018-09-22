//
//  CityService.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/15/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

protocol CityServiceProtocol {
    func loadCities(prefix: String, complete: @escaping (_ cities: [City]? , _ error: String?)->())
}

class CityService: CityServiceProtocol {
    
    // MARK: properities
    
    var dicOfTries: [String : CitiesTrie] = [:]
    
    func loadCities(prefix: String , complete: @escaping (_ cities: [City]? , _ error: String?)->()) {
        
        let methodStart = Date()
        
        var fileCharPrefix = prefix
        
        if prefix.isEmpty {
            fileCharPrefix = "a"
        } else {
            let char = String(prefix.lowercased().first!)
            if char.isNormalChar() {
                // Case normal caharcters
                fileCharPrefix = char
            }else{
                // Case special characters
                fileCharPrefix = "sp"
            }
        }
        
        // Case filePrefix is already loaded and dict contains Trie data of cities
        if let trie = dicOfTries[fileCharPrefix] {
            let searchCities = trie.find(prefix: prefix)
            complete(searchCities, nil)
            
        } else {
            // dict doesn't contain the Trie data of cities and loaded it from it's prefix file
            if let path = Bundle.main.path(forResource: fileCharPrefix, ofType: "json") {
                do {
                    var citiesTrie = CitiesTrie()
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let cities = try JSONDecoder().decode(Array<City>.self, from: data)
                    if let storedTrie = dicOfTries[fileCharPrefix] {
                        citiesTrie = storedTrie
                    } else {
                        for city in cities {
                            citiesTrie.insert(city: city)
                        }
                        dicOfTries[fileCharPrefix] = citiesTrie
                    }
                    
                    let methodFinish = Date()
                    let executionTime = methodFinish.timeIntervalSince(methodStart)
                    print("Execution time: \(executionTime)")
                    
                    complete(cities , nil)
                    
                }catch{
                    print(error)
                    complete(nil , "Can't load all cities")
                }
            }
        }
    }
}

