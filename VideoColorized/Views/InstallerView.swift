//
//  InstallerView.swift
//  VideoColorized
//
//  Created by ly on 14/08/2022.
//

import SwiftUI

struct InstallerView: View {

    @ObservedObject var testManager: TestManager

    init() {
        self.testManager = TestManager.shared
    }
    
    var body: some View {
        VStack() {
            Text("Installer setup")
            
            Button(action: {
                print("Hello World")
                testManager.runBrewScript()
            }) {
                Text("Start now")
               
            }
            
//            VStack() {
                ScrollView {
                        Text(testManager.terminalString)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .background(Color.gray)
                            .frame(minHeight: 300)
                            .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
//            }
//            .frame(maxWidth: .infinity, minHeight: 300.0)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct InstallerView_Previews: PreviewProvider {
    static var previews: some View {
        InstallerView()
    }
}
