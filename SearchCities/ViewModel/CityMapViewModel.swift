//
//  CityMapViewModel.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/21/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

class CityMapViewModel {
 
    var city: City? {
        didSet {
            cityMapLoadCompletion?()
        }
    }
    
    private let cityParameter: City
    
    init(city: City) {
        self.cityParameter = city
    }
    
    var cityMapLoadCompletion: (()->())?
    
    func loadCityMap() {
        self.city = self.cityParameter
    }
}
