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
            InputVideo()
            DestinationView(isSameAsSource: $isSameAsSource, outputPath: $outputPath)
            RenderSettingView(renderFactor: $renderFactor)
            //            VStack(alignment: .center) {
            //                Button(action: { print()}) {
            //                    Text("STOP")
            //                        .padding(.vertical, 5)
            //                        .frame(maxWidth: .infinity, minHeight: 45, maxHeight: .infinity)
            //                }
            //                .font(.title3)
            //                .foregroundStyle(.red)
            //                .padding(20.0)
            //                .foregroundColor(.blue)
            //                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            //            }
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //            .padding(.vertical, 10.0)
            //            .padding(.horizontal, 45.0)
            Button(action: {
                //                testManager = TestManager(total: 4, current: 0)
                //                //                debugPrint("Intel MKL Error. DEBUG=0X005")
                //                //                fatalError("You click on the start button")
                //                testManager?.runProcess()
                // Display popup
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
            
            ConvertProgressView(current: self.$testManager.current)
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


struct InputVideo: View {
    
//    @Binding var files: [VideoFile]
    
    func isVideoExistInList(pathToCheck: String) -> Bool {
        for item in manager.videoFiles {
            if pathToCheck == item.path {
                return true
            }
        }
        return false
    }
    
    @State private var selection = Set<VideoFile.ID>() // <-- Use this for multiple rows selections
    @State private var dragOver = false
    
    let allowVideoExtensions = ["mp4", "mov"]
    @StateObject var manager = TestManager.shared
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("Selected files")
                .font(.system(.body))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .center, spacing: manager.videoFiles.count > 0 ? 0 : 20) {
                if manager.videoFiles.count > 0 {
                    VStack {
                        if #available(macOS 12.0, *) {
                            Table(manager.videoFiles, selection: $selection) {
                                TableColumn("Name", value: \.name)
                                
                                //                TableColumn("") { file in
                                //                    Text(String(file.path))
                                //                }
                            }
                            //                .offset(y: -27)
                            .opacity(0.85)
                            .frame(minHeight: 100)

                            
                        } else {
                            // Fallback on earlier versions
                            List {
                                HStack() {
                                    VStack(alignment: .leading, spacing: 5.0) {
                                        //Column 1 Data
                                        Text("Name")
                                            .padding(.bottom, 2.0)
                                            .foregroundColor(.primary)
                                            .font(.headline)
                                        Divider()
                                        //                                        Divider()
                                        ForEach(manager.videoFiles) { file in
                                            //  Text(person.name) this is list ...
                                            Text(file.path)
                                        }
                                    }
                                }
                            }
                            .frame(minHeight: 100)
                            
                        }
                    }
                }
                else {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            let dialog = NSOpenPanel()
                            dialog.title = "Choose a folder"
                            dialog.showsResizeIndicator = true
                            dialog.showsHiddenFiles = false
                            dialog.canChooseDirectories = false
                            dialog.canCreateDirectories = true
                            dialog.canChooseFiles = true
                            dialog.allowsMultipleSelection = true
                            
                            if dialog.runModal() == NSApplication.ModalResponse.OK {
                                let result = dialog.urls // Pathname of the file
                                print(result)
                                for url in result {
                                    DispatchQueue.main.async {
                                        let video = VideoFile(path: url.path)
                                        manager.videoFiles.append(video)
                                    }
                                }
                            } else {
                                return
                            }
                        }
                    Text("Drop your videos here")
                }
            }
            .padding(.all, manager.videoFiles.count > 0 ? 0 : 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
            .onDrop(of: ["public.file-url"], isTargeted: $dragOver) { providers -> Bool in
                for provider in providers {
                    provider.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                        if let data = data, let path = NSString(data: data, encoding: 4), let url = URL(string: path as String) {
                            if (allowVideoExtensions.contains(url.pathExtension) && isVideoExistInList(pathToCheck: url.path) == false) {
                    
                                DispatchQueue.main.async {
                                    let newVideo = VideoFile(path: url.path)
                                    manager.videoFiles.append(newVideo)
                                    print("NEW PATH::")
                                    debugPrint(url)
                                }
                            }
                            else {
                                print("This file type is not supported.")
                            }
                            
                        }
                    })
                }
                
                return true
            }
            
            Button("Clear all") {
                manager.videoFiles.removeAll()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(Color(red: 1, green: 1, blue: 1))
    }
}

struct RenderSettingView: View {
    @Binding var renderFactor: Int
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Render factor")
                .font(.body)
                .fontWeight(.regular)
            TextField("", value: $renderFactor, formatter: NumberFormatter())
                .frame(width: 28.0)
                .opacity(0.73)
            Stepper("", value: $renderFactor, in: 10...40)
            
        }
        .padding(.horizontal, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ConvertProgressView: View {
    
    private let TOTAL = 100.0
    @Binding var current: Double
    
    //    var manager: TestManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Current progress")
                HStack(alignment: .center, spacing: 10) {
                    if #available(macOS 12.0, *) {
                        ProgressView(value: CGFloat(current), total: TOTAL)
                            .tint(.green)
                    } else {
                        // Fallback on earlier versions
                        ProgressView(value: CGFloat(current), total: TOTAL)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                    }
                    
                    Text(String(current) + "%")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                //                .background(Color(red: 1, green: 1, blue: 1))
            }
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
            //            .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Total progress")
                    .fontWeight(.bold)
                HStack(alignment: .center, spacing: 10) {
                    if #available(macOS 12.0, *) {
                        ProgressView(value: TestManager.shared.calcTotalProgress(), total: TOTAL)
                            .tint(.green)
                    } else {
                        // Fallback on earlier versions
                        ProgressView(value: TestManager.shared.calcTotalProgress(), total: TOTAL)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color.green))
                    }
                    //                    Text("75%")
                    Text(String(TestManager.shared.calcTotalProgress()) + " %")
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity)
                //                .background(Color(red: 1, green: 1, blue: 1))
            }
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
            //            .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0), lineWidth: 1))
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

struct DestinationView: View {
    @Binding var isSameAsSource: Bool
    @Binding var outputPath: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                GroupBox() {
                    VStack {
                        HStack() {
                            TextField("", text: $outputPath)
                                .disabled(true)
                            Button(action: {
                                let dialog = NSOpenPanel()
                                dialog.title = "Choose a folder"
                                dialog.showsResizeIndicator = true
                                dialog.showsHiddenFiles = false
                                dialog.canChooseDirectories = true
                                dialog.canCreateDirectories = true
                                dialog.canChooseFiles = false
                                dialog.allowsMultipleSelection = false
                                
                                if dialog.runModal() == NSApplication.ModalResponse.OK {
                                    let result = dialog.url // Pathname of the file
                                    if result != nil {
                                        outputPath = result!.path
                                        UserDefaults.standard.set(outputPath, forKey: "outputPath")
                                    }
                                } else {
                                    return
                                }
                            }) {
                                Text("Browse")
                            }
                            Button(action: {
                                print("Open output path")
                                NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: outputPath)
                            }) {
                                Text("Open")
                            }
                            
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.all, 10.0)
                        
                        Toggle(isOn: $isSameAsSource) {
                            Text("Same as source")
                        }
                        .padding(.bottom, 15.0)
                        .padding(.horizontal, 10.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .groupBoxStyle(TransparentGroupBox())
                Text("Destination").offset(x: 20, y: -8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct TransparentGroupBox: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity)
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.clear))
            .overlay(configuration.label.padding(.leading, 4), alignment: .topLeading)
            .border(Color(red: 0, green: 0, blue: 0, opacity: 0.3), width: 0.5)
    }
}


struct OrangeGroupBoxStyle: GroupBoxStyle {
    var background: some View {
        RoundedRectangle(cornerRadius: 5)
            .fill(Color.clear)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(background)
            .opacity(1)
            .overlay(
                configuration.label
                    .padding(.leading, 4),
                alignment: .topLeading
            )
            .border(Color.gray, width: 0.5)
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
