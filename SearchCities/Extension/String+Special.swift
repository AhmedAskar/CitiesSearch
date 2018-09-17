//
//  String+Special.swift
//  SearchCities
//
//  Created by Ahmed Askar on 9/17/18.
//  Copyright © 2018 Ahmed Askar. All rights reserved.
//

import Foundation

extension String  {
    
    func isNormalChar() -> Bool {
        let regEx = "[A-Za-z]"
        let regixTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return regixTest.evaluate(with:self)
    }
}
