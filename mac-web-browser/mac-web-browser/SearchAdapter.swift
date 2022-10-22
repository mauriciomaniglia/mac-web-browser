//
//  SearchAdapter.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 22/10/22.
//

import Foundation
import WebKit
import core_web_browser

public final class SearchAdapter {
    let webView: WKWebView
    
    public init(webView: WKWebView) {
        self.webView = webView
    }
    
    public func loadPage(from text: String) {
        if let url = URIFixup.getURL(text) {
            webView.load(URLRequest(url: url))
        }
    }
}
