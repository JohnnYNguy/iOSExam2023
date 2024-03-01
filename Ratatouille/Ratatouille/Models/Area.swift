//
//  Area.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 29/11/2023.
//

import Foundation
import UIKit

struct Area: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    enum CodingKeys: String, CodingKey {
        case strMeal
        case strMealThumb
        case idMeal
    }
}
