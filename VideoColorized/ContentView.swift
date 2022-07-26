//
//  ContentView.swift
//  VideoColorized
//
//  Created by ly on 18/07/2022.
//

import SwiftUI

public struct ContentView: View {
    
    public var body: some View {
        VStack(alignment: .center, spacing: 20) {
            InputVideo()
            DestinationView()
            
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
            Button(action: {}) {
                Text("STOP")
                    .font(.system(size: 13.0))
                    .fontWeight(.medium)
                    .padding(22)
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.red)
//                    .background(Color.blue)
//                    .foregroundColor(Color.white)
            }.frame(height: 30)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 45.0)
//             .background(Color.cle).cornerRadius(5)
            
            
            ConvertProgressView()
            //            .background(Color(red: 1, green: 1, blue: 1))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        //        .background(Color(red: 1, green: 1, blue: 1))
    }
}


struct VideoFile: Identifiable {
    let id: Int
    let name: String
    let path: String
}

struct InputVideo: View {
    @State private var files = [
        VideoFile(id: 1, name: "sample.mp4", path: "~/Desktop/My Videos/sample.mp4"),
        VideoFile(id: 2, name: "testing.mov", path: "~/Desktop/My Videos/testing.mp4"),
        //        VideoFile(id: 3, name: "testing.mov", path: "80"),
        //        VideoFile(id: 4, name: "testing.mov", path: "80"),
        //        VideoFile(id: 5, name: "testing.mov", path: "80"),
        //        VideoFile(id: 6, name: "testing.mov", path: "80"),
        //        VideoFile(id: 7, name: "testing.mov", path: "80"),
        //        VideoFile(id: 8, name: "testing.mov", path: "80"),
        //        VideoFile(id: 9, name: "Adele Adkins", path: "85")
    ]
    @State private var selection = Set<VideoFile.ID>() // <-- Use this for multiple rows selections
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("Selected files")
                .font(.system(.body))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
                Table(files, selection: $selection) {
                    TableColumn("Name", value: \.name)
                    //                TableColumn("") { file in
                    //                    Text(String(file.path))
                    //                }
                }
                .offset(y: -27)
            }
            .clipped()
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
            
            //            VStack(alignment: .center, spacing: 20) {
            //                Image(systemName: "plus.circle")
            //                    .resizable()
            //                    .frame(width: 64, height: 64)
            //                    .foregroundColor(.blue)
            //                Text("Drop your videos here")
            //                    .font(.custom("Inter", size: 13))
            //                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.35))
            //            }
            //            .padding(.all, 20)
            //            .frame(maxWidth: .infinity, maxHeight: .infinity)
            ////            .frame(height: 196)
            //            .cornerRadius(10)
            //            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
            Button("Clear all") {
                
            }
            //            .font(.callout)
            //            .foregroundStyle(.secondary)
            //            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //        .background(Color(red: 1, green: 1, blue: 1))
    }
}

struct RenderSettingView: View {
    @State private var sleepAmount = 8
    
    var body: some View {
        HStack(spacing: 5) {
            Text("Render factor")
                .font(.body)
                .fontWeight(.regular)
            TextField("", value: $sleepAmount, formatter: NumberFormatter())
                .frame(width: 28.0)
            Stepper("", value: $sleepAmount, in: 4...12)
            
        }
        .padding(.horizontal, 9)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ConvertProgressView: View {
    @State private var downloadAmount = 0.0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Current progress")
                HStack(alignment: .center, spacing: 10) {
                    ProgressView(value: 50, total: 100)
                        .foregroundColor(.green)
                    
                    Text("50%")
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
                    ProgressView(value: 75, total: 100)
                        .foregroundColor(.green)
                    Text("75%")
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
    @State private var isOn: Bool = true
    @State private var outputPath: String = "~/Desktop/My Videos/"
    var body: some View {
        VStack() {
            GroupBox("Destination") {
                HStack() {
                    TextField("", text: $outputPath)
                    Button("Browse") {
                        
                    }
                    Button("Open") {
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.all, 10.0)
                
                Toggle(isOn: $isOn) {
                    Text("Same as source")
                }
                .padding(.bottom, 15.0)
                .padding(.horizontal, 10.0)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.clear.opacity(0)
                )
            )
            //            .groupBoxStyle(OrangeGroupBoxStyle())
            .frame(alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        //        ZStack {
        //            Text("Destination")
        //                .font(.custom("Inter", size: 12))
        //                .foregroundColor(Color(red: 0, green: 0, blue: 0))
        //            HStack(alignment: .center, spacing: 16) {
        //            }
        //            .background(Color(red: 1, green: 1, blue: 1))
        //            .position(x: 270.5, y: 34)
        //        }
        //        .frame(maxWidth: .infinity, alignment: .topLeading)
        //        .background(Color(red: 1, green: 1, blue: 1, opacity: 0))
        //        .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0.09), lineWidth: 1))
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
            .preferredColorScheme(.light)
        //        ConvertProgressView().preferredColorScheme(.dark)
    }
}
