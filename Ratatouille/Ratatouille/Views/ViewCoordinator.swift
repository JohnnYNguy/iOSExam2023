//
//  ViewCoordinator.swift
//  Ratatouille
//
//  Created by Johnny Nguyen on 03/12/2023.
//

import SwiftUI

struct ViewCoordinator: View {
    @State private var isActive: Bool = false
    
    var body: some View {
        if self.isActive {
            ContentView()
        } else {
            SplashScreenView(isActive: $isActive)
        }
    }
}

struct ViewCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        ViewCoordinator()
    }
}
