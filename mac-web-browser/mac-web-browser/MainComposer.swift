//
//  MainComposer.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 22/10/22.
//

import AppKit

final class MainComposer {
    static func composerWebView() {
        let mainWindowController = NSApplication.shared.windows.first?.windowController as! MainWindowController
        let contentViewController = mainWindowController.contentViewController as! MainViewController
        let searchAdapter = SearchAdapter(webView: contentViewController.webView)
        
        mainWindowController.didSendText = searchAdapter.loadPage(from:)
    }
}
