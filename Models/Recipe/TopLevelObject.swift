//
//  TopLevelObject.swift
//  Meal-Likey
//
//  Created by Jenny Morales on 12/14/21.
//

import Foundation

//hashable figures out if the data needs to change
struct TopLevelObject: Codable, Hashable {
    let count: Int
    let results: [Recipe]
}
