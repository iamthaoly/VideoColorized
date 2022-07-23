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
            Button("CONVERT") {
                
            }
                .font(.callout)
                .foregroundStyle(.primary)
                .foregroundColor(.blue)
            ConvertProgressView()
//            .background(Color(red: 1, green: 1, blue: 1))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
//        .background(Color(red: 1, green: 1, blue: 1))
    }
}




struct InputVideo: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("Selected files")
                .font(.system(.body))
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.blue)
                Text("Drop your videos here")
                    .font(.custom("Inter", size: 13))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.35))
            }
            .padding(.all, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
//            .frame(height: 196)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
            Button("Clear all") {
                
            }
            .font(.callout)
            .foregroundStyle(.secondary)
            .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(red: 1, green: 1, blue: 1))
    }
}

struct RenderSettingView: View {
    @State private var sleepAmount = 8

    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            Text("Render factor")
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
            TextField("", value: $sleepAmount, formatter: NumberFormatter())
            Stepper("", value: $sleepAmount, in: 4...12)
            
        }
        .padding(.horizontal, 9)
        .frame(alignment: .leading)
    }
}

struct ConvertProgressView: View {
    @State private var downloadAmount = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Current progress")
                    .font(.custom("Inter", size: 11))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                HStack(alignment: .center, spacing: 10) {
                    ProgressView(value: 50, total: 100)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    Text("50%")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))
                }
                .frame(maxWidth: .infinity)
//                .background(Color(red: 1, green: 1, blue: 1))
            }
            .padding(.all, 5)
            .frame(maxWidth: .infinity)
//            .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0), lineWidth: 1))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Total progress")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                HStack(alignment: .center, spacing: 10) {
                    ProgressView(value: 75, total: 100)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Text("75%")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))
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
                .padding(.bottom, 5.0)
                .frame(maxWidth: .infinity)
            }
            .frame(alignment: .leading)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(hue: 1.0, saturation: 0.0, brightness: 1.0, opacity: 0.0)/*@END_MENU_TOKEN@*/)
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 616, height: 616)
            .preferredColorScheme(.light)
//        ConvertProgressView().preferredColorScheme(.dark)
    }
}
