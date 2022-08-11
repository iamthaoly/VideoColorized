//
//  ContentView.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI

public struct ContentView: View {
    @State var isDisplayCompletedAlert = false

    @State var testManager: TestManager = TestManager.shared

    @State private var isSameAsSource = false
    
    @State private var files = [
        VideoFile(id: 1, name: "sample.mp4", path: "~/Desktop/My Videos/sample.mp4"),
//        VideoFile(id: 2, name: "testing.mov", path: "~/Desktop/My Videos/testing.mp4"),
        //                VideoFile(id: 3, name: "testing.mov", path: "80"),
        //                VideoFile(id: 4, name: "testing.mov", path: "80"),
        //                VideoFile(id: 5, name: "testing.mov", path: "80"),
        //                VideoFile(id: 6, name: "testing.mov", path: "80"),
        //                VideoFile(id: 7, name: "testing.mov", path: "80"),
        //                VideoFile(id: 8, name: "testing.mov", path: "80"),
        //                VideoFile(id: 9, name: "Adele Adkins", path: "85")
    ]
    
    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            InputVideo(files: $files)
            DestinationView(isSameAsSource: $isSameAsSource)
            RenderSettingView()
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
//                isDisplayCompletedAlert = true
                // Display popup
                print("Increase current!")
                testManager.current += 2
            }) {
                Text("START")
                    .font(.system(size: 13.0))
                    .fontWeight(.medium)
                    .padding(22)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                //                    .foregroundStyle(.red)
                //                    .background(Color.blue)
                //                    .foregroundColor(Color.white)
            }
            .frame(height: 30)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 45.0)
            .alert("Converting completed", isPresented: $isDisplayCompletedAlert) {
                if isSameAsSource {
                    // TODO: Open destination folder
//                    Button("Open destination folder") {
//
//                    }
                }
                Button("OK") { }
            }
            
            ConvertProgressView(manager: $testManager)
            
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        
    }
}


struct VideoFile: Identifiable {
    let id: Int
    let name: String
    let path: String
}


struct InputVideo: View {

    @Binding var files: [VideoFile]
    
    func isVideoExist(pathToCheck: String) -> Bool {
        for item in files {
            if pathToCheck == item.path {
                return true
            }
        }
        return false
    }
    
    @State private var selection = Set<VideoFile.ID>() // <-- Use this for multiple rows selections
    @State private var dragOver = false

    let allowVideoExtensions = ["mp4", "mov"]
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("Selected files")
                .font(.system(.body))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .center, spacing: files.count > 1 ? 0 : 20) {
                if files.count > 1 {
                    VStack {
                        Table(files, selection: $selection) {
                            TableColumn("Name", value: \.name)
                            
                            //                TableColumn("") { file in
                            //                    Text(String(file.path))
                            //                }
                        }
                        //                .offset(y: -27)
                        .opacity(0.85)
                    }
                }
                else {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.blue)
                    Text("Drop your videos here")
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.35))
                }
            }
            .padding(.all, files.count > 1 ? 0 : 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
            .onDrop(of: ["public.file-url"], isTargeted: $dragOver) { providers -> Bool in
                for provider in providers {
                    provider.loadDataRepresentation(forTypeIdentifier: "public.file-url", completionHandler: { (data, error) in
                        if let data = data, let path = NSString(data: data, encoding: 4), let url = URL(string: path as String) {
                            if (allowVideoExtensions.contains(url.pathExtension) && isVideoExist(pathToCheck: url.path) == false) {
                                
                                let newVideo = VideoFile(id: files.count, name: url.lastPathComponent, path: url.path)
                                
                                files.append(newVideo)
                                print("NEW PATH::")
                                debugPrint(url)
        //                        let image = NSImage(contentsOf: url)
    //                            DispatchQueue.main.async {
    //    //                            self.image = image
    //                                print("Do anything!!")
    //                            }
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
                files.removeAll()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(Color(red: 1, green: 1, blue: 1))
    }
}

struct RenderSettingView: View {
    @State private var sleepAmount = 21
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Render factor")
                .font(.body)
                .fontWeight(.regular)
            TextField("", value: $sleepAmount, formatter: NumberFormatter())
                .frame(width: 28.0)
                .opacity(0.73)
            Stepper("", value: $sleepAmount, in: 10...40)
            
        }
        .padding(.horizontal, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ConvertProgressView: View {
    private let TOTAL = 100.0
    @State var currentProgress = 0.0
    @Binding var manager: TestManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Current progress")
                HStack(alignment: .center, spacing: 10) {
                    ProgressView(value: CGFloat(manager.current), total: TOTAL)
                        .tint(.green)
                    
                    Text(String(manager.current) + "%")
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
                    ProgressView(value: CGFloat(manager.total), total: TOTAL)
                        .tint(.green)
//                    Text("75%")
                    Text(String(manager.total) + "%")
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
    @State private var outputPath: String = "~/Desktop/My Videos/"
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                GroupBox("") {
                    VStack {
                        HStack() {
                            TextField("", text: $outputPath)
                            //                                .opacity(0.85)
                                .disabled(true)
                            Button("Browse") {
                                
                            }
                            Button("Open") {
                                
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
