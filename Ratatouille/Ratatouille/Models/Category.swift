//
//  Category.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 24/11/2023.
//

import Foundation
import UIKit

struct Category: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}
