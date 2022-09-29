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
    var mainController: MainViewController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let mainViewController = NSApplication.shared.windows.first?.contentViewController as? MainViewController {
            mainController = mainViewController
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
        if let url = URIFixup.getURL(text) {
            mainController?.webView.load(URLRequest(url: url))
        }
    }
}

