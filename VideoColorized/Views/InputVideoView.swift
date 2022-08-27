//
//  InputVideoView.swift
//  VideoColorized
//
//  Created by ly on 27/08/2022.
//

import SwiftUI

struct InputVideoView: View {
    
    func isVideoExistInList(pathToCheck: String) -> Bool {
        for item in manager.videoFiles {
            if pathToCheck == item.path {
                return true
            }
        }
        return false
    }
    
    func selectInputVideos() {
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
                                        ForEach(manager.videoFiles) { file in
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
                            selectInputVideos()
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
struct InputVideoView_Previews: PreviewProvider {
    static var previews: some View {
        InputVideoView()
    }
}
