//
//  TestManager.swift
//  VideoColorized
//
//  Created by ly on 07/08/2022.
//

import Foundation
//import Darwin

class TestManager: ObservableObject {
    var total: Int
    @Published var current: Double
    @Published var terminalString: String = ""
    
    @Published var isBrewDone: Bool = false
    @Published var isInitDone: Bool = false
    
    @Published var videoFiles: [String] = []
    @Published var currentVideoIndex: Int?
    
    @Published var isRunning: Bool = false
    
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
    
    private func clearResult() {
        DispatchQueue.main.async {
            self.terminalString = ""
        }
    }
    
    // MARK: - PUBLIC
    func calcTotalProgress() -> Double {
        let res = currentVideoIndex == nil ? 0.0 : 100.0 / Double(videoFiles.count) * Double(currentVideoIndex! + 1)
        return res
    }

    func colorizeVideos(sameAsSource: Bool = true, renderFactor: Int = 21) {
        clearResult()
        // source result
        print("Activate env")
        let envCommand = ". $HOME/colorized-python/venv/bin/activate"
        let strInput = "$HOME/colorized-python/input3_color_10fps.mp4"
        let strOutput = "$HOME/Desktop/sample_output.mp4"
        
        let pythonCommand = "python3 $HOME/colorized-python/runner.py -i \(strInput) -o \(strOutput) -r \(renderFactor)"
        
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", envCommand + "; " + pythonCommand]
        
        let myPipe = Pipe()
        task.standardOutput = myPipe
        let outHandle = myPipe.fileHandleForReading
          
        let errPipe = Pipe()
        task.standardError = errPipe
        let errHandle = errPipe.fileHandleForReading
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stdout: This command is done!")
                    myPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        //                        Update result
                        
                    }
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output stdout: \(line)")
                        // Update progress
                        if line.contains("%") {
                            
                        }
//                        self.updateString(line)
                    }
                }

            }
        }
        
        errHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stderr: This command is done!")
                    errPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        // Update result
                    }
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output stderr: \(line)")
//                        self.updateString(line)
                    }
                }

            }
        }

        task.launch()
        task.waitUntilExit()
    }
    
    func runInstallerInTerminal() {
        let url = URL(fileURLWithPath: "brew_script.sh", relativeTo: Bundle.main.resourceURL)
        let url2 = URL(fileURLWithPath: "init_script.sh", relativeTo: Bundle.main.resourceURL)
        let url3 = URL(fileURLWithPath: "FIRST_RUN.sh", relativeTo: Bundle.main.resourceURL)

//        let brew_script = "sh " + url.path
//        let init_script = "sudo sh " + url2.path
        let terminalPath = "/System/Applications/Utilities/Terminal.app"

        let command = "open -a \(terminalPath) " + url3.path
        print("Current install command")
        print(command)
        
        print("Set the running permission for the script...")
        let setPermissionScript = ["chmod 755 " + url.path, "chmod 755 " + url2.path, "chmod 755 " + url3.path]
        for item in setPermissionScript {
            print(item)
            print(item.runAsCommand())
        }
//        let res = command.runAsCommand()
//        print(res)
        
    
    }
    
}
// MARK: - ARCHIVED
extension TestManager {
    
    private func runPythonScript() -> String {
        let runnerPath = PYTHON_PATH + "/" + "runner.py"
        let command = "python3 " + runnerPath
        
        return command.runAsCommand()
    }
    
    func runProcess() {
//        let executableURL = URL(fileURLWithPath: "/usr/bin/say")
////           self.isRunning = true
//        try! Process.run(executableURL, arguments: [],
//                        terminationHandler: { _ in print("Stop running.") })
        
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
    
    func testGetProcess() {
//        let pythonCommand = "python3 sers/ly/Desktop/progress.py"
        
        let task = Process()
        task.launchPath = "/bin/sh"

//        task.launchPath = "/usr/bin/python3"
//        task.arguments = ["-c", "python3" + "; " + pythonCommand]
//        task.arguments = [pythonCommand]
        task.arguments = ["-c", "ls $HOME/Desktop"]
        
        let myPipe = Pipe()
        task.standardOutput = myPipe
        let outHandle = myPipe.fileHandleForReading
        
        let errPipe = Pipe()
        task.standardError = errPipe
        let errHandle = errPipe.fileHandleForReading
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stdout: This command is done!")
                    myPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        // Update result
                    }
                }
                else {
                    print("New output stdout: \(line)")
                    self.updateString(line)

                    if line != "" && line.count > 0 {
                        print("New output stdout: \(line)")
                        // Update progress
                        if line.contains("%") {
                            print(line)
                        }
//                        self.updateString(line)
                    }
                }

            }
        }
        
        errHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stderr: This command is done!")
                    errPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        // Update result
                        // result - - - - - - - - - - - - - - - - - - - - - - - - -
                    }
                }
                else {
                    print("New output stderr: \(line)")
                    self.updateString(line)
                    if line != "" && line.count > 0 {
                        print("New output stderr: \(line)")
//                        self.updateString(line)
//
                    }
                }

            }
        }
        task.launch()
//        task.waitUntilExit()
    }
    
    func runBrewScript() {
//        setbuf(stdout, nil)
        terminalString = ""
        let url = URL(fileURLWithPath: "brew_script.sh", relativeTo: Bundle.main.resourceURL)
        var command = "sh " + url.path
        command = "echo \"abc\""
        print("Command: ")
        print(command)
        updateString(command + "\n")

        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", "echo abc"]
//        task.arguments = ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"]

        let myPipe = Pipe()
        task.standardOutput = myPipe
        let outHandle = myPipe.fileHandleForReading
        
        let errPipe = Pipe()
        task.standardError = errPipe
        let errHandle = errPipe.fileHandleForReading
        
//        task.terminationHandler =
//            {
////                (process) in
////                fin = not(process.isRunning)
//            }
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stdout: This command is done!")
                    myPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
//                        self.isBrewDone = true
                    }
//                    self.runInitScript()
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output stdout: \(line)")
                        self.updateString(line)
                    }
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }
        errHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stderr: This command is done!")
                    errPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        self.isBrewDone = true
                    }
                    self.runInitScript()
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output stderr: \(line)")
                        self.updateString(line)
                    }
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }

        task.launch()
        task.waitUntilExit()
    }
    
    func runInitScript() {
        
//        DispatchQueue.main.async {
//            self.terminalString = ""
//        }
        updateString("Cloning the repo...\n")
        updateString("Done.\n")
        updateString("Installing the requirements...\n")
        let url = URL(fileURLWithPath: "init_script.sh", relativeTo: Bundle.main.resourceURL)
        
        let init_script = "sudo sh " + url.path
        let command = "osascript -e 'set res to do shell script \"\(init_script)\" with administrator privileges'"
        
//        osascript -e 'do shell script "sudo sh /Users/ly/Library/Developer/Xcode/DerivedData/VideoColorized-fasmgghulfsoipaubgggctofklhx/Build/Products/Debug/VideoColorized.app/Contents/Resources/init_script.sh" with administrator privileges'
    //        osascript -e 'do shell script "(echo a>&2)2>&1"'

        print("Command: ")
        print(command)
        let task = Process()
        updateString(command + "\n")


        task.launchPath = "/bin/sh"
        task.arguments = ["-c", command]
//        task.arguments = ["-c", "echo 1 ; sleep 1 ; echo 2 ; sleep 1 ; echo 3 ; sleep 1 ; echo 4"]

        let myPipe = Pipe()
        task.standardOutput = myPipe
        let outHandle = myPipe.fileHandleForReading

        
        let errPipe = Pipe()
        task.standardError = errPipe
        let errHandle = errPipe.fileHandleForReading
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stdout: This command is done!")
                    myPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
//                        self.isInitDone = true
                    }
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output: \(line)")
                        self.updateString(line)
                    }
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }

        errHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ) {
                if pipe.availableData.isEmpty  {
                    print("EOF stderr: This command is done!")
                    errPipe.fileHandleForReading.readabilityHandler = nil
                    DispatchQueue.main.async {
                        self.isInitDone = true
                    }
                }
                else {
                    if line != "" && line.count > 0 {
                        print("New output stderr: \(line)")
                        self.updateString(line)
                    }
                }

            } else {
                print("Error decoding data: \(pipe.availableData)")
                self.updateString ("Error decoding data: \n")
                self.updateString ("\( pipe.availableData)")
            }
        }

        task.launch()
        task.waitUntilExit()
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
