//
//  VideoColorizedApp.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI

@main
struct VideoColorizedApp: App {
    var goHome = false
    var body: some Scene {
        WindowGroup {
            if (goHome) {
                HomeScreen()
                    .navigationTitle("Homescreen")
            }
            else {
                InstallerScreen()
                    .navigationTitle("Installer")
            }
            
        }
            
    }
}
