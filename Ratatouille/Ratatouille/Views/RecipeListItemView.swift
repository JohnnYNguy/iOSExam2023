//
//  RecipeListItemView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 21/11/2023.
//

import SwiftUI

struct RecipeListItemView: View {
    let meal: Meal
    
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
                    EmptyView()
                }
            }
                
            
            VStack {
                Text(meal.strMeal)
                    .font(.title)
                Text(meal.strCategory)
            }
        }
    }
}

