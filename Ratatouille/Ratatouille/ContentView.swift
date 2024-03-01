//
//  ContentView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State var showSplash: Bool = false
    @State var category = [Category]()
    @State var area = [Area]()
    @State var ingredient = [Ingredient]()
        
    func onAppear() {
        
    }
    
    
    var body: some View {
        TabView {
            RecipesView()
                .tabItem {
                    Label("My Recipes", systemImage: "fork.knife.circle.fill")
                }
            SearchView(area: area, category: category, ingredient: ingredient)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
