//
//  MainComposer.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 22/10/22.
//

import AppKit

final class MainComposer {
    static func composerWebView() {
        let mainViewController = NSApplication.shared.windows.first?.contentViewController as! MainViewController
        let searchAdapter = SearchAdapter(webView: mainViewController.webView)
        
        mainViewController.didSendText = searchAdapter.loadPage(from:)
    }
}
