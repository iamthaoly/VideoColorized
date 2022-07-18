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
            VStack(alignment: .trailing, spacing: 5) {
                Text("Selected files")
                    .font(.custom("Inter", size: 12))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
                VStack(alignment: .center, spacing: 0) {
                    Text("Drop your videos here")
                        .font(.custom("Inter", size: 13))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0, opacity: 0.35))
                }
                .padding(.all, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 196)
                .background(Color(red: 1, green: 1, blue: 1, opacity: 0.50))
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.29, green: 0.57, blue: 0.97), lineWidth: 1))
                VStack(alignment: .leading, spacing: 10) {
                    Text("Clear all")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.24))
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 3)
                .background(Color(red: 1, green: 1, blue: 1))
                .cornerRadius(6)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color(red: 0, green: 0, blue: 0, opacity: 0.12), lineWidth: 0.5))
                .compositingGroup()
                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 1, x: 0, y: 0.5)
            }
            .frame(maxWidth: .infinity)
            .background(Color(red: 1, green: 1, blue: 1))
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
            HStack(alignment: .center, spacing: 5) {
                Text("Render factor")
                    .font(.custom("Inter", size: 11))
                    .foregroundColor(Color(red: 0, green: 0, blue: 0))
            }
            .padding(.horizontal, 9)
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack(alignment: .center, spacing: 81) {
            }
            .padding(.horizontal, 45)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            VStack(alignment: .leading, spacing: 5) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Current progress")
                        .font(.custom("Inter", size: 11))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))
                    HStack(alignment: .center, spacing: 10) {
                        ZStack {
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(Color(red: 1, green: 1, blue: 1))
                        Text("0%")
                            .font(.custom("Inter", size: 11))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1, green: 1, blue: 1))
                }
                .padding(.all, 5)
                .frame(maxWidth: .infinity)
                .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0), lineWidth: 1))
                VStack(alignment: .leading, spacing: 5) {
                    Text("Total progress")
                        .font(.custom("Inter", size: 12))
                        .foregroundColor(Color(red: 0, green: 0, blue: 0))
                    HStack(alignment: .center, spacing: 10) {
                        ZStack {
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(Color(red: 1, green: 1, blue: 1))
                        Text("0%")
                            .font(.custom("Inter", size: 11))
                            .foregroundColor(Color(red: 0, green: 0, blue: 0))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 1, green: 1, blue: 1))
                }
                .padding(.all, 5)
                .frame(maxWidth: .infinity)
                .overlay(Rectangle().stroke(Color(red: 0, green: 0, blue: 0, opacity: 0), lineWidth: 1))
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color(red: 1, green: 1, blue: 1))
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .background(Color(red: 1, green: 1, blue: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
