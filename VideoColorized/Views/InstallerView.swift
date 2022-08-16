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
                        if #available(macOS 12.0, *) {
                            Text(testManager.terminalString)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(minHeight: 240)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
//                                .textSelection(.enabled)
                                .contextMenu {
                                    Button(action: {
                                        NSPasteboard.general.clearContents()
                                        NSPasteboard.general.setString(testManager.terminalString, forType: .string)
                                        }) {
                                            Text("Copy the log.")
                                        }
                                }
                        } else {
                            Text(testManager.terminalString)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(minHeight: 240)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                                .contextMenu {
                                    Button(action: {
                                        NSPasteboard.general.clearContents()
                                        NSPasteboard.general.setString(testManager.terminalString, forType: .string)
                                        }) {
                                            Text("Copy!")
                                        }
                                }
                        }

                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.black)
            .alert(isPresented: $testManager.isInitDone) {
                return Alert(title: Text("Convert completed"), dismissButton: .default(Text("OK"), action: {
                    //TODO:  Go to homescreen
                    moveToHomeScreen = true
                    
                }))
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

