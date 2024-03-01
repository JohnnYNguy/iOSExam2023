//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @Environment(\.managedObjectContext) var moc
    
    @State var sheetIsPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                }
                Section {
                    Button {
                        sheetIsPresented = true
                    } label: {
                        Text("Archived Recipes")
                    }
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $sheetIsPresented) {
                ArchivedRecipesView()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
