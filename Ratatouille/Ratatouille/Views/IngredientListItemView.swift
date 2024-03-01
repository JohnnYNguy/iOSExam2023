//
//  IngredientListItemView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 01/12/2023.
//

import SwiftUI

struct IngredientListItemView: View {
    let ingredient: Ingredient
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: ingredient.strMealThumb!)) { phase in
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
                        EmptyView()
                }
            }
            
            VStack {
                Text(ingredient.strMeal ?? "")
                    .font(.title)
            }
        }
    }
}

struct IngredientListItemView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientListItemView(ingredient: Ingredient(strMeal: "Baked salmon with fennel & tomatoes", strMealThumb: "https://www.themealdb.com/images/media/meals/1548772327.jpg", idMeal: "52959"))
    }
}
