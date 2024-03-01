//
//  SavedRecipeDetailView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 02/12/2023.
//

import SwiftUI

struct SavedRecipeDetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [.init(key: "strMeal", ascending: true)]) var recipes: FetchedResults<Recipes>
    
    let meal: Recipes
    
    @State private var tabIndex = 0
    
    @State var sheetIsPresented: Bool = false
    
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
            HStack {
                Text(meal.strMeal!)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                Button {
                    sheetIsPresented = true
                } label: {
                    Text("Edit")
                }
            }
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
                    Text("Area: \(meal.strArea!)")
                    Text("Category: \(meal.strCategory!)")
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
                            Text("\(meal.strIngredient1!): \(meal.strMeasure1!)")
                            Text("\(meal.strIngredient2!): \(meal.strMeasure2!)")
                            Text("\(meal.strIngredient3!): \(meal.strMeasure3!)")
                            Text("\(meal.strIngredient4!): \(meal.strMeasure4!)")
                            Text("\(meal.strIngredient5!): \(meal.strMeasure5!)")
                            Text("\(meal.strIngredient6!): \(meal.strMeasure6!)")
                            Text("\(meal.strIngredient7!): \(meal.strMeasure7!)")
                            Text("\(meal.strIngredient8!): \(meal.strMeasure8!)")
                            Text("\(meal.strIngredient9!): \(meal.strMeasure9!)")
                            
                            ForEach(1...20, id: \.self) { i in
                                if let ingredient = getIngredient(forIndex: i), let measure = getMeasure(forIndex: i) {
                                    Text("\(ingredient): \(measure)")
                                }
                            }
                        }
                    }
                } else {
                    ScrollView {
                        Text(meal.strInstructions!)
                            .lineLimit(nil)
                            .padding()
                    }
                }
            }
            Spacer()
        }.sheet(isPresented: $sheetIsPresented) {
            EditSavedRecipesView(sheetIsPresented: $sheetIsPresented, meal: meal)
        }
    }
}

//struct SavedRecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedRecipeDetailView()
//    }
//}
