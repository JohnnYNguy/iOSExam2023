//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 15/11/2023.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .preferredColorScheme(isDarkMode ? .dark : .light)
//                .environment(\.managedObjectContext, dataController.container.viewContext)
            ViewCoordinator()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
