//
//  AppDelegate.swift
//  CpuSpeed
//
//  Created by Fredrik Sellgren on 2019-08-22.
//  Copyright © 2019 Fredrik Sellgren. All rights reserved.
//

import Cocoa
import Foundation
@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        guard let statusButton = statusBarItem.button else { return }
        init_c()
        _ = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block:
        { timer in
//            var TestString = String(shell("sh /Users/fredriksellgren/CpuSpeed/CpuSpeed/Script.sh"))
//            TestString.remove(at: TestString.index(before: TestString.endIndex))
//            TestString.remove(at: TestString.index(before: TestString.endIndex))
//            _ = Int(Float(TestString)!)
            let freqInt = String(frequency())
            let tempInt = String(temperature())
            let powerInt = String(power())
            statusButton.title = freqInt + " GHz | " + tempInt + "°C | " + powerInt + " W"
            
        })
        constructMenu()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        destroy();
    }
    func constructMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusBarItem.menu = menu
    }
}

var statusBarItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)


@discardableResult
private func shell(_ args: String) -> String {
    var outstr = ""
    let task = Process()
    task.launchPath = "/bin/sh"
    task.arguments = ["-c", args]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        outstr = output as String
    }
    task.waitUntilExit()
    return outstr
}

