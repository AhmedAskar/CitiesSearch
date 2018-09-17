//
//	City.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/14/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

struct City: Codable {
    let _id: Int
    let country : String
    let name : String
    let coord : Coord
}

struct Coord: Codable {
    let lat : Double
    let lon : Double
}

