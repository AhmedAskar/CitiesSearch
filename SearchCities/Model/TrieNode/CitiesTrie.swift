//
//  CitiesTrie.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/17/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

class CitiesTrie {
    
    private let root: CityNode
    
    init() {
        root = CityNode(value: " ", parent: nil)
    }
    
    func insert(city: City) {
        guard !city.name.isEmpty else { return }
        
        var currentNode = root
        
        let characters = Array("\(city.name.lowercased()),\(city.country.lowercased())")
        var currentIndex = 0
        
        while currentIndex < characters.count {
            let character = characters[currentIndex]
            
            if let child = currentNode.children[character] {
                currentNode = child
            } else {
                if currentIndex == characters.count - 1 {
                    currentNode.add(value: character, city: city)
                } else {
                    currentNode.add(value: character, city: nil)
                }
                currentNode = currentNode.children[character]!
            }
            currentIndex += 1
        }
    }
    
    func find(prefix: String) -> [City] {
        guard !prefix.isEmpty else { return [] }
        let characters = Array(prefix.lowercased())
        var currentNode = root
        for character in characters {
            guard let node = currentNode.children[character] else {return []}
            currentNode = node
        }
        
        return currentNode.getAllChildNodes()
    }
}
