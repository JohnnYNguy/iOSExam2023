//
//  Ingredient.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 01/12/2023.
//

import Foundation
import UIKit

struct Ingredient: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}
