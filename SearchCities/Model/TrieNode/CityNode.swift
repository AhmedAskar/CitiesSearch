//
//  CityNode.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/17/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

class CityNode {
    
    var value: Character
    var city: City?
    weak var parent: CityNode?
    var children: [Character: CityNode] = [:]
    
    init(value: Character, city: City? = nil, parent: CityNode?) {
        self.value = value
        self.city = city
        self.parent = parent
    }
    
    func add(value: Character, city: City?) {
        guard children[value] == nil else { return }
        children[value] = CityNode(value: value, city: city, parent: self)
    }
    
    func getAllChildNodes() -> [City] {
        var list = [City]()
        if let city = self.city{ list.append(city) }
        let sortedChildrenKeys = children.keys.sorted()
        for key in sortedChildrenKeys {
            list.append(contentsOf: children[key]!.getAllChildNodes())
        }
        return list
    }
}
