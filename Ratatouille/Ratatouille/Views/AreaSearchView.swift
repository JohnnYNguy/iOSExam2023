//
//  AreaSearchView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 29/11/2023.
//

import SwiftUI

struct AreaSearchView: View {
    
    @State var area: [Area]
    @State var areaSearch: String = ""
    @State var meals: [Meal]?
    
    @State var mealSearch: String = ""
    @State var detailSheetIsPresented: Bool = false
    
    func onAppear() {
        guard !areaSearch.isEmpty else {
            return
        }
        Task {
            do {
                let areas = try await APIClient.live.getArea(areaSearch)
//                print(areas)
                DispatchQueue.main.async {
                    self.area = areas
                    print(areas)
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
            TextField("Search area...", text: $areaSearch, onCommit: {
                onAppear()
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .onChange(of: areaSearch) { _ in
                onAppear()
            }
            
            List(area, id: \.strMeal) { area in
                Button {
                    mealSearch = area.strMeal!
                    getMeal()
                    detailSheetIsPresented = true
                } label: {
                    AreaListItemView(area: area)
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

//struct AreaSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        AreaSearchView()
//    }
//}
