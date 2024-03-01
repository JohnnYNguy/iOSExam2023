//
//  RecipeDetailView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 21/11/2023.
//

import SwiftUI
import CoreData

struct RecipeDetailView: View {
    let meal: Meal
    
    @State private var tabIndex = 0
    
    @State private var showAlert = false
    
    @Environment(\.managedObjectContext) var moc
    
    func saveRecipe() {
        // Check if a record with the same strMeal already exists
        let fetchRequest: NSFetchRequest<Recipes> = Recipes.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "strMeal == %@", meal.strMeal)
        
        do {
            let existingRecipes = try moc.fetch(fetchRequest)
            if let existingRecipe = existingRecipes.first {
                // Record with the same strMeal exists, you can update it or handle it as needed
                print("Record with the same strMeal already exists:", existingRecipe)
                showAlert = true
                // Handle the situation (e.g., update existing record or skip saving)
            } else {
                // No record with the same strMeal found, proceed to save a new record
                let entityDescription = NSEntityDescription.entity(forEntityName: "Recipes", in: moc)!
                let recipes = Recipes(entity: entityDescription, insertInto: moc)
                
//                 ... (Rest of your existing code to set properties)
                        recipes.isArchived = false
                
                        recipes.idMeal = meal.idMeal
                        recipes.strMeal = meal.strMeal
                        recipes.strDrinkAlternate = meal.strDrinkAlternate
                        recipes.strCategory = meal.strCategory
                        recipes.strArea = meal.strArea
                
                        recipes.strInstructions = meal.strInstructions
                        recipes.strMealThumb = meal.strMealThumb
                        recipes.strTags = meal.strTags
                        recipes.strYoutube = meal.strYoutube
                
                        recipes.strIngredient1 = meal.strIngredient1
                        recipes.strIngredient2 = meal.strIngredient2
                        recipes.strIngredient3 = meal.strIngredient3
                        recipes.strIngredient4 = meal.strIngredient4
                        recipes.strIngredient5 = meal.strIngredient5
                        recipes.strIngredient6 = meal.strIngredient6
                        recipes.strIngredient7 = meal.strIngredient7
                        recipes.strIngredient8 = meal.strIngredient8
                        recipes.strIngredient9 = meal.strIngredient9
                        recipes.strIngredient10 = meal.strIngredient10
                        recipes.strIngredient11 = meal.strIngredient11
                        recipes.strIngredient12 = meal.strIngredient12
                        recipes.strIngredient13 = meal.strIngredient13
                        recipes.strIngredient14 = meal.strIngredient14
                        recipes.strIngredient15 = meal.strIngredient15
                        recipes.strIngredient16 = meal.strIngredient16
                        recipes.strIngredient17 = meal.strIngredient17
                        recipes.strIngredient18 = meal.strIngredient18
                        recipes.strIngredient19 = meal.strIngredient19
                        recipes.strIngredient20 = meal.strIngredient20
                
                        recipes.strMeasure1 = meal.strMeasure1
                        recipes.strMeasure2 = meal.strMeasure2
                        recipes.strMeasure3 = meal.strMeasure3
                        recipes.strMeasure4 = meal.strMeasure4
                        recipes.strMeasure5 = meal.strMeasure5
                        recipes.strMeasure6 = meal.strMeasure6
                        recipes.strMeasure7 = meal.strMeasure7
                        recipes.strMeasure8 = meal.strMeasure8
                        recipes.strMeasure9 = meal.strMeasure9
                        recipes.strMeasure10 = meal.strMeasure10
                        recipes.strMeasure11 = meal.strMeasure11
                        recipes.strMeasure12 = meal.strMeasure12
                        recipes.strMeasure13 = meal.strMeasure13
                        recipes.strMeasure14 = meal.strMeasure14
                        recipes.strMeasure15 = meal.strMeasure15
                        recipes.strMeasure16 = meal.strMeasure16
                        recipes.strMeasure17 = meal.strMeasure17
                        recipes.strMeasure18 = meal.strMeasure18
                        recipes.strMeasure19 = meal.strMeasure19
                        recipes.strMeasure20 = meal.strMeasure20
                
                        recipes.strSource = meal.strSource
                        recipes.strImageSource = meal.strImageSource
                        recipes.strCreativeCommonsConfirmed = meal.strCreativeCommonsConfirmed
                        recipes.dateModified = meal.dateModified
                
                moc.saveAndPrintError()
                print(recipes)
            }
        } catch {
            // Handle fetch error
            print("Error fetching existing records:", error)
        }
    }
    
    func getIngredient(forIndex index: Int) -> String? {
        let ingredientKey = "strIngredient\(index)"
        if let ingredient = getProperty(forKey: ingredientKey, in: meal) as? String, !ingredient.isEmpty {
            return ingredient
        }
        return nil
    }
    
    func getMeasure(forIndex index: Int) -> String? {
        let measureKey = "strMeasure\(index)"
        if let measure = getProperty(forKey: measureKey, in: meal) as? String, !measure.isEmpty {
            return measure
        }
        return nil
    }
    
    func getProperty(forKey key: String, in object: Any) -> Any? {
        let mirror = Mirror(reflecting: object)
        for child in mirror.children {
            if let label = child.label, label == key {
                return child.value
            }
        }
        return nil
    }
    
    var body: some View {
        VStack {
            Text(meal.strMeal)
                .font(.largeTitle)
                .padding()
            
            AsyncImage(url: URL(string: meal.strMealThumb!)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 300, maxHeight: 300)
                        .cornerRadius(25)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            
            Spacer()
            
            HStack {
                VStack {
                    Text("Area: \(meal.strArea)")
                    Text("Category: \(meal.strCategory)")
                }
                
                Spacer()
                
                Button {
                    saveRecipe()
                    print("tapped save")
                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                Picker(selection: $tabIndex, label: Text("DetailParts"), content: {
                    Text("Ingredients").tag(0)
                    Text("Instructions").tag(1)
                })
                .pickerStyle(SegmentedPickerStyle())
                
                if tabIndex == 0 {
                    ScrollView {
                        VStack {
                            ForEach(1...20, id: \.self) { i in
                                if let ingredient = getIngredient(forIndex: i), let measure = getMeasure(forIndex: i) {
                                    Text("\(ingredient): \(measure)")
                                }
                            }
                        }
                    }
                } else {
                    ScrollView {
                        Text(meal.strInstructions)
                            .lineLimit(nil)
                            .padding()
                    }
                }
            }
            Spacer()
        }.alert("Save Error", isPresented: $showAlert) {
            Text("This recipe is already saved")
        } message: {
            Text("This recipe is already saved")
        }
    }
}

extension NSManagedObjectContext {
    func saveAndPrintError() {
        do {
            try self.save()
        } catch let error {
            print(error)
        }
    }
}

//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
