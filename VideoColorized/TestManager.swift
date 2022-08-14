//
//  TestManager.swift
//  VideoColorized
//
//  Created by ly on 07/08/2022.
//

import Foundation

class TestManager: ObservableObject {
    var total: Int
    @Published var current: Double
    
    let PYTHON_PATH = "/Users/ly/colorized-python"
//    var currentProgress: Float? = 0.5
//    var totalProgress: Float? = 0.75
    
    static let shared = TestManager()

    private init() {
        total = 0
        current = 0
    }
    
    private init(total: Int, current: Double) {
        self.total = total
        self.current = current
    }
    
    func count() {
        Timer()
    }
    
    func increase() {
        current += 10
        if current >= 100 {
            current = 100
        }
    }
    
    func runProcess() {
//        let executableURL = URL(fileURLWithPath: "/usr/bin/say")
////           self.isRunning = true
//        try! Process.run(executableURL, arguments: [],
//                        terminationHandler: { _§ in print("Stop running.") })
        
//        let task = Process()
//        task.launchPath = "pwd"
////            task.launchPath = "/usr/local/bin/python3"
////            task.arguments = ["/Users/justMe/Desktop/test/test.py"]
//        task.launch()
//        task.waitUntilExit()
//        print ("All Done!")
        
        let url = URL(fileURLWithPath: "PyOnMac", isDirectory: true, relativeTo: Bundle.main.resourceURL)
        let input = "source " + url.path + "/bin/activate"
        print("Input command")
        print(input)
        
        let output = input.runAsCommand()
        print(output)

        
//        let url = URL(fileURLWithPath: "main.py", relativeTo: Bundle.main.resourceURL)
//        let input = "python3 " + url.path
//        let output = input.runAsCommand()
//        print(output)
    }
    
    private func runPythonScript() -> String {
        
        let runnerPath = PYTHON_PATH + "/" + "runner.py"
        let command = "python3 " + runnerPath
        
        return command.runAsCommand()
    }
    
    
    func runTerminal() {
        print("Activate env")
        let envCommand = ". $HOME/colorized-python/venv/bin/activate"
        let res = envCommand.runAsCommand()
        debugPrint(res)
        
        let runnerPath = PYTHON_PATH + "/" + "runner.py"
        let command = "python3 " + runnerPath
        
        print("Command: ")
        print(command)
        let task = Process()

        task.launchPath = "/bin/sh"
        task.arguments = ["-c", envCommand + " ; " + command]

        let pipe = Pipe()
        task.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading

        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                // Update your view with the new text here
                print("New ouput: \(line)")
            } else {
                print("Error decoding data: \(pipe.availableData)")
            }
        }

        task.launch()
    }
    
    
    private func createEnv() {
        //      Create virtualenv
        let commands = [
            "virtualenv -p python3 path",
            "source .../bin/activate"
        ]
        
        let pythonFolder = URL(fileURLWithPath: "PyOnMac", isDirectory: true, relativeTo: Bundle.main.resourceURL)
        var env = pythonFolder
        
        if #available(macOS 13.0, *) {
            env = pythonFolder.appending(path: "venv")
        } else {
            // Fallback on earlier versions
            env = pythonFolder.appendingPathComponent("venv")
        }
        
        
        let virtualenv2 = "virtualenv -p python3 " + env.path
    }
}

extension String {
    func runAsCommand() -> String {
        let pipe = Pipe()
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", String(format:"%@", self)]
        task.standardOutput = pipe
        let file = pipe.fileHandleForReading
        task.launch()
//        task.waitUntilExit()
        if let result = NSString(data: file.readDataToEndOfFile(), encoding: String.Encoding.utf8.rawValue) {
            return result as String
        }
        else {
            return "--- Error running command - Unable to initialize string from file data ---"
        }
    }
}
