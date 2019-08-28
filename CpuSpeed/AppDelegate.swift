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
            let freqInt = String(frequency())
            let tempInt = String(temperature())
            let powerInt = String(power())
            statusButton.title = freqInt + " GHz | " + tempInt + "°C | " + powerInt + " W"
            
        })
        constructMenu()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
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

