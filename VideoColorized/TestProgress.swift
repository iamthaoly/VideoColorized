//
//  TestProgress.swift
//  VideoColorized
//
//  Created by ly on 23/07/2022.
//

import SwiftUI

struct TestProgress: View {
    var body: some View {
        ProgressView(value: 50.0, total: 100)
            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        
    }
}

struct TestProgress_Previews: PreviewProvider {
    static var previews: some View {
        TestProgress()
    }
}
