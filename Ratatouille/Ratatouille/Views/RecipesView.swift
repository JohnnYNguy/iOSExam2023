//
//  RecipesView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import SwiftUI
import CoreData

struct RecipesView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [.init(key: "strMeal", ascending: true)], predicate: NSPredicate(format: "isArchived == false")) var recipes: FetchedResults<Recipes>
    
    var body: some View {
        VStack {
            if !recipes.isEmpty {
                NavigationView {
                    List(recipes) { recipes in
                        NavigationLink {
                            SavedRecipeDetailView(meal: recipes)
                        } label: {
                            SavedRecipeListItemView(meal: recipes)
                        }.swipeActions {
                            Button {
                                recipes.isArchived = true
                                moc.saveAndPrintError()
                            } label: {
                                Image(systemName: "archivebox")
                            }
                            .tint(.blue)
                        }
                    }.navigationTitle("My Recipes")
                }
            } else {
                NavigationView {
                    VStack {
                        Spacer()
                        Image(systemName: "rectangle.portrait.on.rectangle.portrait.slash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("No Recipes")
                            .font(.title)
                        Spacer()
                    }.navigationTitle("My Recipes")
                }
            }
        }
    }
}

//struct RecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipesView()
//    }
//}
