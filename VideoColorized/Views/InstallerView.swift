//
//  InstallerView.swift
//  VideoColorized
//
//  Created by ly on 14/08/2022.
//

import SwiftUI

struct InstallerView: View {
    @State var isDisplayCompletedAlert = false
    @State var moveToHomeScreen = true
    @ObservedObject var testManager: TestManager

    init() {
        self.testManager = TestManager.shared
        testManager.terminalString =
        """
        The app needs to download and install some packages.
        Please click on "Start Now" button to start the installation progress.
        \n
        Note: The installation progress will take about 30 minutes to 2 hours. Please have some tea and come back later. :)\n
        -The developer-
        """
    }
    
    var body: some View {
        VStack() {
            Text("Installer Setup")
                .foregroundColor(.primary)
                .font(.title3)
                .padding(.bottom, 15.0)
            Button(action: {
                testManager.runBrewScript()
            }) {
                Text("Start Now")
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
                            .padding()
                            .frame(minHeight: 240)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
//                                .textSelection(.enabled)
                            .contextMenu {
                                Button(action: {
                                    NSPasteboard.general.clearContents()
                                    NSPasteboard.general.setString(testManager.terminalString, forType: .string)
                                    }) {
                                        Text("Copy")
                                    }
                            }
                            .id("log")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.black)
            .alert(isPresented: $moveToHomeScreen) {
                return Alert(title: Text("The installation progress is completed"), dismissButton: .default(Text("OK"), action: {
                    //TODO:  Go to homescreen
//                    moveToHomeScreen = true
//                    OpenWindows.InstallerWindow.open()
                }))
            }
            
        }
        .frame(maxWidth: .infinity, minHeight: 300.0, maxHeight: .infinity)
        .padding(.all, 10.0)

    }
}

struct InstallerView_Previews: PreviewProvider {
    static var previews: some View {
        InstallerView()
    }
}

