//
//  CategoryListItemView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 30/11/2023.
//

import SwiftUI

struct CategoryListItemView: View {
    let category: Category
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: category.strMealThumb!)) { phase in
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
                Text(category.strMeal ?? "")
                    .font(.title)
            }
        }
    }
}

//struct CategoryListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryListItemView()
//    }
//}
