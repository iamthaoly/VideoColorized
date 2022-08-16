//
//  VideoColorizedApp.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI

@main
struct VideoColorizedApp: App {
    var body: some Scene {
        WindowGroup {
            if (Utils.hasCompleteInstaller()) {
                HomeScreen()
                    .navigationTitle("Homescreen")
            }
            else {
                InstallerScreen()
                    .navigationTitle("Installer")
            }
            
        }
//        WindowGroup("InstallerWindow") {
//            InstallerScreen()
//        }.handlesExternalEvents(matching: Set(arrayLiteral: "InstallerWindow"))
            
    }
}

//enum OpenWindows: String, CaseIterable {
//    case InstallerWindow = "InstallerWindow"
//
//    func open(){
//        if let url = URL(string: "myapp://\(self.rawValue)") { //replace myapp with your app's name
//            NSWorkspace.shared.open(url)
//        }
//    }
//}
