//
//  ArchivedRecipesView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 03/12/2023.
//

import SwiftUI

struct ArchivedRecipesView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [.init(key: "strMeal", ascending: true)], predicate: NSPredicate(format: "isArchived == true")) var recipes: FetchedResults<Recipes>
    
    var body: some View {
        VStack {
            if !recipes.isEmpty {
                NavigationView {
                    List(recipes) { recipes in
                        NavigationLink {
                            SavedRecipeDetailView(meal: recipes)
                        } label: {
                            SavedRecipeListItemView(meal: recipes)
                        }
                        .swipeActions {
                            Button {
                                moc.delete(recipes)
                                moc.saveAndPrintError()
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            Button {
                                recipes.isArchived = false
                                moc.saveAndPrintError()
                            } label: {
                                Image(systemName: "archivebox")
                            }
                            .tint(.blue)
                        }
                    }.navigationTitle("Archived Recipes")
                }
            } else {
                NavigationView {
                    VStack {
                        Spacer()
                        Image(systemName: "archivebox")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Text("No Recipes")
                            .font(.title)
                        Spacer()
                    }.navigationTitle("Archived Recipes")
                }
            }
        }
    }
}

//struct ArchivedRecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ArchivedRecipesView()
//    }
//}
