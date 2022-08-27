//
//  ContentView.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI

public struct ContentView: View {
    @State var isDisplayCompletedAlert = false
    
    @ObservedObject var testManager: TestManager
    
    @State private var isSameAsSource = true
    @State var outputPath: String = ((UserDefaults.standard.string(forKey: "outputPath") ?? (NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true) as [String]).first) ?? "")
    @State var renderFactor: Int = 21
    
    init() {
        self.testManager = TestManager.shared
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            InputVideoView()
            DestinationView(isSameAsSource: $isSameAsSource, outputPath: $outputPath)
            RenderSettingView(renderFactor: $renderFactor)

            Button(action: {
                //                testManager = TestManager(total: 4, current: 0)
                //                //                debugPrint("Intel MKL Error. DEBUG=0X005")
                //                //                fatalError("You click on the start button")
                //                testManager?.runProcess()
                // TODO: - Display popup
//                print("Increase current!")
//                testManager.increase()
//                if testManager.current >= 100.0 {
//                    isDisplayCompletedAlert = true
//                }
//                testManager.runTerminal()
                if testManager.videoFiles.count > 0 {
                    if testManager.isRunning {
                        testManager.isRunning = !testManager.isRunning
                    }
                    else {
                        testManager.isRunning = !testManager.isRunning
                        testManager.colorizeVideos(sameAsSource: isSameAsSource, outputPath: outputPath, renderFactor: renderFactor)
                    }


                }

            }) {
                Text(testManager.isRunning ? "STOP" : "START")
                    .font(.system(size: 13.0))
                    .fontWeight(.medium)
                    .padding(22)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
//                    .foregroundStyle(.red)
//                        .background(Color.blue)
                //                    .foregroundColor(Color.white)
            }
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 45.0)
            .alert(isPresented: $isDisplayCompletedAlert) {
                if isSameAsSource {
                    // TODO: Open destination folder
                    //                    Button("Open destination folder") {
                    //                    }
                }
                return Alert(title: Text("Convert completed"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Cancel")))
                //                                Button("OK") { }
            }
            
            ConvertProgressView(current: self.$testManager.currentVideoProgress)
            ScrollView {
                Text(testManager.terminalString)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, minHeight: 50)
            
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        //        ForEach(ColorScheme.allCases, id: \.self, content: ContentView()
        //            .frame(width: 616, height: 616).preferredColorScheme)
        
        ContentView()
            .frame(width: 616, height: 616)
        //            .preferredColorScheme(.light)
        //        ConvertProgressView().preferredColorScheme(.dark)
    }
}
