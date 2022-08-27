//
//  ConvertProgressView.swift
//  VideoColorized
//
//  Created by ly on 27/08/2022.
//

import SwiftUI

struct ConvertProgressView: View {
    
    private let TOTAL = 100.0
    @Binding var current: Double
        
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

struct ConvertProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertProgressView(current: .constant(50.0))
    }
}
