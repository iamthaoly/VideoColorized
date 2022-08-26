//
//  VideoFile.swift
//  VideoColorized
//
//  Created by ly on 14/08/2022.
//

import Foundation

struct VideoFile: Identifiable {
    var id = UUID()
    var name: String
    var path: String
    var url: URL
    
    init(path: String) {
        self.path = path
        self.url = URL.init(fileURLWithPath: path)
        self.name = url.lastPathComponent
    }
}
