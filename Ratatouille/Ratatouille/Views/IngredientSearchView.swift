//
//  IngredientSearchView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 29/11/2023.
//

import SwiftUI

struct IngredientSearchView: View {
    
    @State var ingredientSearch: String = ""
    @State var ingredient: [Ingredient]
    @State var meals: [Meal]?
    
    @State var mealSearch: String = ""
    @State var detailSheetIsPresented: Bool = false
    
    func onAppear() {
        guard !ingredientSearch.isEmpty else {
            return
        }
        
        Task {
            do {
                let ingredients = try await APIClient.live.getIngredient(ingredientSearch)
                print(ingredients)
                DispatchQueue.main.async {
                    self.ingredient = ingredients
                    print(ingredients)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func getMeal() {
        guard !mealSearch.isEmpty else {
            return
        }
        
        guard let encodedSearchTerm = mealSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        Task {
            do {
                let meals = try await APIClient.live.getMeals(encodedSearchTerm)
                DispatchQueue.main.async {
                    self.meals = meals
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search ingredient...", text: $ingredientSearch, onCommit: {
                onAppear()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: ingredientSearch) { _ in
                onAppear()
            }
            
            List(ingredient, id: \.strMeal) { ingredient in
                Button {
                    mealSearch = ingredient.strMeal!
                    getMeal()
                    detailSheetIsPresented = true
                } label: {
                    IngredientListItemView(ingredient: ingredient)
                }
            }
        }.sheet(isPresented: $detailSheetIsPresented) {
            if let unwrappedMeals = meals, let firstMeal = unwrappedMeals.first {
                RecipeDetailView(meal: firstMeal)
            }
        }
        .onAppear {
            onAppear()
        }
    }
}

//struct IngredientSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientSearchView()
//    }
//}
