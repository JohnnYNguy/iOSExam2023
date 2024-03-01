//
//  SearchView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import SwiftUI

struct SearchView: View {
    @State private var tabIndex = 0
    
    @State var meals: [Meal]?
    @State var area: [Area]
    @State var category: [Category]
    @State var ingredient: [Ingredient]
    @State var userSearch: String = ""
    @State var categorySearch: String = ""
    
    func onAppear() {
        guard !userSearch.isEmpty else {
            return
        }
        
        guard let encodedSearchTerm = userSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        Task {
            do {
                let meals = try await APIClient.live.getMeals(encodedSearchTerm)
                print(meals)
                DispatchQueue.main.async {
                    self.meals = meals
                    print(meals)
                }
                
                let categories = try await APIClient.live.getCategory(categorySearch)
                print(categories)
                DispatchQueue.main.async {
                    self.category = categories
                    print(categories)
                }
                
                
            } catch let error {
                print(error)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $tabIndex, label: Text("Search Options"), content: {
                    Image(systemName: "magnifyingglass").tag(0)
                    Image(systemName: "globe").tag(1)
                    Image(systemName: "fork.knife").tag(2)
                    Image(systemName: "carrot.fill").tag(3)
                })
                .pickerStyle(SegmentedPickerStyle())
                                
                if tabIndex == 0 {
                    VStack {
                        TextField("Search recipe...", text: $userSearch, onCommit: {
                            onAppear()
                        })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: userSearch) { _ in
                            onAppear()
                        }

                        List(meals ?? [], id: \.idMeal) { meal in
                            NavigationLink {
                                RecipeDetailView(meal: meal)
                            } label: {
                                RecipeListItemView(meal: meal)
                            }
                        }
                    }
                    .onAppear {
                        onAppear()
                    }
                } else if tabIndex == 1 {
                    AreaSearchView(area: area)
                    Spacer()
                } else if tabIndex == 2 {
//                    Text("Category")
                    CategorySearchView(category: category)
                } else if tabIndex == 3 {
//                    Text("Ingredient")
                    IngredientSearchView(ingredient: ingredient)
                }
            }
            .navigationTitle("Search")
        }
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
