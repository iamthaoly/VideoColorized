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
            ZStack {
                Text("Destination")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                HStack(alignment: .center, spacing: 16) {
                }
                .background(Color(red: 1, green: 1, blue: 1))
                .position(x: 270.5, y: 34)
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color(red: 1, green: 1, blue: 1, opacity: 0))
            .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0.09), lineWidth: 1))
            
            RenderSettingView()

            ProgressView()
//            .background(Color(red: 1, green: 1, blue: 1))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
//        .background(Color(red: 1, green: 1, blue: 1))
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView()
//            .frame(width: 616, height: 616)
//            .preferredColorScheme(.dark)
        ProgressView().preferredColorScheme(.dark)
    }
}
//

struct InputVideo: View {
    var body: some View {
        VStack(alignment: .trailing, spacing: 5) {
            Text("Selected files")
                .font(.system(.body))
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
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
            .font(/*@START_MENU_TOKEN@*/.callout/*@END_MENU_TOKEN@*/)
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

struct ProgressView: View {
    @State private var downloadAmount = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Current progress")
                    .font(.custom("Inter", size: 11))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                HStack(alignment: .center, spacing: 10) {
//                    ProgressView()
                    Text("0%")
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
                    Text("0%")
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
