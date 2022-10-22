//
//  AppDelegate.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 12/09/22.
//

import Cocoa
import core_web_browser

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        MainComposer.composerWebView()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

