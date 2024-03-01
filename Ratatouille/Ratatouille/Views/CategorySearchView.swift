//
//  CategorySearchView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 24/11/2023.
//

import SwiftUI

struct CategorySearchView: View {
    
    @State var categorySearch: String = ""
    @State var category: [Category]
    @State var meals: [Meal]?
    
    @State var mealSearch: String = ""
    @State var detailSheetIsPresented: Bool = false
    
    func onAppear() {
        guard !categorySearch.isEmpty else {
            return
        }
        
        Task {
            do {
                let categories = try await APIClient.live.getCategory(categorySearch)
                print(categories)
                DispatchQueue.main.async {
                    self.category = categories
                    print(categories)
                }
                
                let meals = try await APIClient.live.getMeals(mealSearch)
                print(meals)
                DispatchQueue.main.async {
                    self.meals = meals
                    print(meals)
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
            TextField("Search category...", text: $categorySearch, onCommit: {
                onAppear()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: categorySearch) { _ in
                onAppear()
            }

            List(category, id: \.idMeal) { category in
                Button {
                    mealSearch = category.strMeal!
                    getMeal()
                    detailSheetIsPresented = true
                } label: {
                    CategoryListItemView(category: category)
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

//struct CategorySearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategorySearchView()
//    }
//}
