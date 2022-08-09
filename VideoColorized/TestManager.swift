//
//  TestManager.swift
//  VideoColorized
//
//  Created by ly on 07/08/2022.
//

import Foundation

class TestManager {
    var total: Int
    var current: Int
    
    var currentProgress: Float? = 0.5
    var totalProgress: Float? = 0.75
    
    
    init(total: Int, current: Int) {
        self.total = total
        self.current = current
    }
    
    func count() {
        Timer()
    }
    
    func runProcess() {
//        let executableURL = URL(fileURLWithPath: "/usr/bin/say")
////           self.isRunning = true
//        try! Process.run(executableURL, arguments: [],
//                        terminationHandler: { _ in print("Stop running.") })
        
        let task = Process()
            task.launchPath = "/usr/local/bin/python3"
            task.arguments = ["/Users/justMe/Desktop/test/test.py"]
            task.launch()
            task.waitUntilExit()
            print ("All Done!")
    }
}
