//
//  AreaListItemView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 30/11/2023.
//

import SwiftUI

struct AreaListItemView: View {
    let area: Area
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: area.strMealThumb!)) { phase in
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
                Text(area.strMeal ?? "")
                    .font(.title)
            }
        }
    }
}

//struct AreaListItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        AreaListItemView()
//    }
//}
