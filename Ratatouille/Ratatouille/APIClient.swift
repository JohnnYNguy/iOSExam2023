//
//  APIClient.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import Foundation

struct APIClient {
    var getMeals: ((String) async throws -> [Meal])
    var getArea: ((String) async throws -> [Area])
    var getCategory: ((String) async throws -> [Category])
    var getIngredient: ((String) async throws -> [Ingredient])
    
}

extension APIClient {
    static let live = APIClient(getMeals: { userSearch in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=\(userSearch)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let mealsResponse = try JSONDecoder().decode([String: [Meal]].self, from: data)
        let meals = mealsResponse["meals"] ?? []
        return meals
    },
                                getArea: { area in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let areaResponse = try JSONDecoder().decode([String: [Area]].self, from: data)
        let areas = areaResponse["meals"] ?? []
        
        return areas
    },
                                getCategory: { category in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let categoryResponse = try JSONDecoder().decode([String: [Category]].self, from: data)
        let categories = categoryResponse["meals"] ?? []
        
        return categories
        
    },
                                getIngredient: { ingredient in
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        let ingredientResponse = try JSONDecoder().decode([String: [Ingredient]].self, from: data)
        let ingredients = ingredientResponse["meals"] ?? []
        return ingredients
    }
    )
}
