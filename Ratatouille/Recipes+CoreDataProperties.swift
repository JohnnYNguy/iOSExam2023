//
//  Recipes+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 02/12/2023.
//
//

import Foundation
import CoreData


extension Recipes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipes> {
        return NSFetchRequest<Recipes>(entityName: "Recipes")
    }

    @NSManaged public var idMeal: String?
    @NSManaged public var strMeal: String?
    @NSManaged public var strDrinkAlternate: String?
    @NSManaged public var strCategory: String?
    @NSManaged public var strArea: String?
    @NSManaged public var strInstructions: String?
    @NSManaged public var strMealThumb: String?
    @NSManaged public var strTags: String?
    @NSManaged public var strYoutube: String?
    @NSManaged public var strIngredient1: String?
    @NSManaged public var strIngredient2: String?
    @NSManaged public var strIngredient3: String?
    @NSManaged public var strIngredient4: String?
    @NSManaged public var strIngredient5: String?
    @NSManaged public var strIngredient6: String?
    @NSManaged public var strIngredient7: String?
    @NSManaged public var strIngredient8: String?
    @NSManaged public var strIngredient9: String?
    @NSManaged public var strIngredient10: String?
    @NSManaged public var strIngredient11: String?
    @NSManaged public var strIngredient12: String?
    @NSManaged public var strIngredient13: String?
    @NSManaged public var strIngredient14: String?
    @NSManaged public var strIngredient15: String?
    @NSManaged public var strIngredient16: String?
    @NSManaged public var strIngredient17: String?
    @NSManaged public var strIngredient18: String?
    @NSManaged public var strIngredient19: String?
    @NSManaged public var strIngredient20: String?
    @NSManaged public var strMeasure1: String?
    @NSManaged public var strMeasure2: String?
    @NSManaged public var strMeasure3: String?
    @NSManaged public var strMeasure4: String?
    @NSManaged public var strMeasure5: String?
    @NSManaged public var strMeasure6: String?
    @NSManaged public var strMeasure7: String?
    @NSManaged public var strMeasure8: String?
    @NSManaged public var strMeasure9: String?
    @NSManaged public var strMeasure10: String?
    @NSManaged public var strMeasure11: String?
    @NSManaged public var strMeasure12: String?
    @NSManaged public var strMeasure13: String?
    @NSManaged public var strMeasure14: String?
    @NSManaged public var strMeasure15: String?
    @NSManaged public var strMeasure16: String?
    @NSManaged public var strMeasure17: String?
    @NSManaged public var strMeasure18: String?
    @NSManaged public var strMeasure19: String?
    @NSManaged public var strMeasure20: String?
    @NSManaged public var strSource: String?
    @NSManaged public var strImageSource: String?
    @NSManaged public var strCreativeCommonsConfirmed: String?
    @NSManaged public var dateModified: String?
    @NSManaged public var isArchived: Bool

}

extension Recipes : Identifiable {

}
