//
//  CustomStyle.swift
//  VideoColorized
//
//  Created by ly on 27/08/2022.
//

import SwiftUI

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
