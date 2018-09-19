//
//  CitiesViewModel.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/15/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

enum ListResult {
    case all
    case search(text: String)
}

class CitiesViewModel {
    
    // MARK: Properities
    
    private var cityService: CityServiceProtocol
    
    // MARK: Properities observation
    
    var cities: [City] = [City]() {
        didSet {
            citiesLoadCompletion?()
        }
    }
    
    var errorMessage: String? {
        didSet {
            errorCitiesFailuer?()
        }
    }
    
    // MARK: Callbacks
    
    var citiesLoadCompletion: (()->())?
    var errorCitiesFailuer: (()->())?
 
    //MARK: init
    
    init(cityService: CityServiceProtocol = CityService()) {
        self.cityService = cityService
    }
    
    func loadCities(text: String) {
        cityService.loadCities(prefix: text) { [weak self] (cities, error) in
            if let error = error {
                self?.errorMessage = error
            }else{
                if let resultCities = cities {
                    self?.cities = resultCities
                }
            }
        }
    }
    
    func findCities(result: ListResult) {
        switch result {
        case .all:
            // Loading Cities from a prefix file by default
            loadCities(text: "a")
        case .search(let text):
            loadCities(text: text)
        }
    }
}
