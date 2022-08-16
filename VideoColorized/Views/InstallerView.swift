//
//  InstallerView.swift
//  VideoColorized
//
//  Created by ly on 14/08/2022.
//

import SwiftUI

struct InstallerView: View {
    @State var isDisplayCompletedAlert = false
    @State var moveToHomeScreen = false
    @ObservedObject var testManager: TestManager

    init() {
        self.testManager = TestManager.shared
        testManager.terminalString =
        """
            1.Python Python Python Python Python Python Python Python Python Python Python Python Python Python Python Python Python Python Python
            2.Terminal
            3.FFMPEG
            4.Virtualenv
        """
    }
    
    var body: some View {
        VStack() {
            Text("Installer setup")
                .foregroundColor(.primary)
                .font(.title3)
            Text("We need to ")
            Button(action: {
                print("Hello World")
                testManager.runBrewScript()
            }) {
                Text("Start now")
            }
            
            Text("Installer log")
                .padding(.top, 10.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(testManager.terminalString)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(minHeight: 240)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.black)
            .alert(isPresented: $testManager.isBrewDone) {
                return Alert(title: Text("Convert completed"), dismissButton: .default(Text("Okay"), action: {
                    //TODO:  Go to homescreen
                    moveToHomeScreen = true
                    
                }))
//                                Button("OK") { }
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: 300.0, maxHeight: .infinity)
        .padding(.all, 10.0)
//        .navigate(to: HomeScreen(), when: $moveToHomeScreen)

    }
}

struct InstallerView_Previews: PreviewProvider {
    static var previews: some View {
        InstallerView()
    }
}

