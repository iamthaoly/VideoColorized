//
//  Utils.swift
//  VideoColorized
//
//  Created by ly on 11/08/2022.
//

import Foundation

class Utils {
    
    static func hasCompleteInstaller() -> Bool {
        let defaults = UserDefaults.standard
        let completeInstall = defaults.bool(forKey: "completeInstall")
        return completeInstall
    }
    
    static func setCompleteInstaller(_ isCompleted: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(isCompleted, forKey: "completeInstall")
    }
    
    
}
