//
//  EditSavedRecipesView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 03/12/2023.
//

import SwiftUI
import CoreData

struct EditSavedRecipesView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [.init(key: "strMeal", ascending: true)]) var recipes: FetchedResults<Recipes>
    
    @Binding var sheetIsPresented: Bool
    
    let meal: Recipes
    
    @State var newStrMeal: String = ""
    @State var newStrCategory: String = ""
    @State var newStrArea: String = ""
    
    @State var newStrInstructions: String = ""
    
    func updateRecipe() {
        
        if !newStrMeal.isEmpty {
            meal.strMeal = newStrMeal
        }
        
        if !newStrCategory.isEmpty {
            meal.strCategory = newStrCategory
        }
        
        if !newStrArea.isEmpty {
            meal.strArea = newStrArea
        }
        
        if !newStrInstructions.isEmpty {
                meal.strInstructions = newStrInstructions
            }
        
        moc.saveAndPrintError()
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Edit Recipe")
                    .font(.title)
                
                Spacer()
                
                Button {
                    updateRecipe()
                    sheetIsPresented = false
                } label: {
                    Text("Save")
                }
            }
            .padding()
            
            Spacer()
            
            VStack {
                ScrollView {
                    TextField(meal.strMeal!, text: $newStrMeal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField(meal.strCategory!, text: $newStrCategory)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField(meal.strArea!, text: $newStrArea)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField(meal.strInstructions!, text: $newStrInstructions)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
            }
            .padding()
            
            Spacer()
        }
    }
}

//struct EditSavedRecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditSavedRecipesView()
//    }
//}
