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
    @Published var terminalString: String = ""
    
    let PYTHON_PATH = FileManager.default.homeDirectoryForCurrentUser.path + "/colorized-python"
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
    
    private func updateString(_ text: String) {
        DispatchQueue.main.async {
            self.terminalString += text
        }
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

    }
    
    private func runPythonScript() -> String {
        let runnerPath = PYTHON_PATH + "/" + "runner.py"
        let command = "python3 " + runnerPath
        
        return command.runAsCommand()
    }
    
    
    func runBrewScript() {
        
        terminalString = ""
        
        let url = URL(fileURLWithPath: "brew_script.sh", relativeTo: Bundle.main.resourceURL)
        
        let command = "sh " + url.path
        
        print("Command: ")
        print(command)
        let task = Process()
        updateString(command + "\n")


        task.launchPath = "/bin/sh"
        task.arguments = ["-c", command]
//        task.arguments = ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"]

        let pipe = Pipe()
        task.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading

        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                // Update your view with the new text here
                if line != "" && line.count > 0 {
                    print("New output: \(line)")
                    self.updateString(line)
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }

        task.launch()
    }
    
    func runInitScript() {
        
        terminalString = ""
        
        let url = URL(fileURLWithPath: "init_script.sh", relativeTo: Bundle.main.resourceURL)
        
        let init_script = "sudo sh " + url.path
        let command = "osascript do shell script \"\(init_script)\" with administrator privileges"
        print("Command: ")
        print(command)
        let task = Process()
        updateString(command + "\n")


        task.launchPath = "/bin/sh"
        task.arguments = ["-c", command]
//        task.arguments = ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"]

        let pipe = Pipe()
        task.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading

        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                // Update your view with the new text here
                if line != "" && line.count > 0 {
                    print("New output: \(line)")
                    self.updateString ("\n")
                    self.updateString (line)
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }

        task.launch()
    }
    
    func runTerminal() {
        print("Activate env")
        let envCommand = ". $HOME/colorized-python/venv/bin/activate"
        let res = envCommand.runAsCommand()
        debugPrint(res)
        updateString(res + "\n")
        
        let runnerPath = PYTHON_PATH + "/" + "runner.py"
        let command = "python3 " + runnerPath
        
        print("Command: ")
        print(command)
        let task = Process()
        updateString(command + "\n")


        task.launchPath = "/bin/sh"
        task.arguments = ["-c", envCommand + " ; " + command]
//        task.arguments = ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"]

        let pipe = Pipe()
        task.standardOutput = pipe
        let outHandle = pipe.fileHandleForReading

        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                // Update your view with the new text here
                if line != "" && line.count > 0 {
                    print("New output: \(line)")
                    self.updateString("New output \n")
                    self.updateString(line + "\n")
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString("Error decoding data: \n")
                self.updateString("\( pipe.availableData)")
            }
        }

        task.launch()
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
