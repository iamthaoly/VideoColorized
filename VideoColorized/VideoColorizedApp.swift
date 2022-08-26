//
//  VideoColorizedApp.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI
import SwiftUIWindow

@main
struct VideoColorizedApp: App {
    var body: some Scene {
        WindowGroup {
            if (Utils.hasCompleteInstaller()) {
                HomeScreen()
                    .navigationTitle("Homescreen")
            }
            else {
                //                HomeScreen()
                //                    .navigationTitle("Homescreen")
                InstallerScreen()
                    .navigationTitle("Installer")
            }
            
        }
        .commands {
            CommandGroup(replacing: .help) {
                Button(action: {
                    SwiftUIWindow.open {_ in
                        InstallerScreen()
                    }
                }) {
                    Text("Open installer")
                }
            }
        }
        //        WindowGroup("InstallerWindow") {
        //            InstallerScreen()
        //        }.handlesExternalEvents(matching: Set(arrayLiteral: "InstallerWindow"))
        
    }
    
    func showWindow() {
        var windowRef: NSWindow
        
        windowRef = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 500, height: 600),
            styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
            backing: .buffered, defer: false)
//        windowRef.contentView = NSHostingView(rootView: InstallerScreen(myWindow: windowRef))
        windowRef.makeKeyAndOrderFront(nil)
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
