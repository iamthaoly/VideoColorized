//
//  DestinationView.swift
//  VideoColorized
//
//  Created by ly on 27/08/2022.
//

import SwiftUI

struct DestinationView: View {
    @Binding var isSameAsSource: Bool
    @Binding var outputPath: String
    
    func selectDestinationFolder() {
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
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topLeading) {
                GroupBox() {
                    VStack {
                        HStack() {
                            TextField("", text: $outputPath)
                                .disabled(true)
                            Button(action: {
                                selectDestinationFolder()
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


struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(isSameAsSource: .constant(true), outputPath: .constant(""))
    }
}
