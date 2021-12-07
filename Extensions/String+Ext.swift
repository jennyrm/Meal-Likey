//
//  String+Ext.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/2/21.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

//    mutating func capitalizeFirstLetter() {
//        self = self.capitalizingFirstLetter()
//    }
}

