//
//  AppDelegate.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 12/09/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let mainViewController = NSApplication.shared.windows.first?.contentViewController as? MainViewController {
            mainViewController.delegate = self
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate: MainViewControllerDelegate {
    func sendText(_ text: String) {
        print(text)
    }
}

