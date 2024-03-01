//
//  SavedRecipeListItemView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 02/12/2023.
//

import SwiftUI

struct SavedRecipeListItemView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [.init(key: "strMeal", ascending: true)]) var recipes: FetchedResults<Recipes>
    
    let meal: Recipes
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: meal.strMealThumb!)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 100, maxHeight: 100)
                        .cornerRadius(50)
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
                
            
            VStack {
                Text(meal.strMeal!)
                    .font(.title)
                Text(meal.strCategory!)
            }
        }

    }
}

//struct SavedRecipeListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavedRecipeListItemView()
//    }
//}
