//
//  SearchAdapterTests.swift
//  mac-web-browserTests
//
//  Created by Mauricio Cesar on 22/10/22.
//

import XCTest
import mac_web_browser
import WebKit

class SearchAdapterTests: XCTestCase {
    func test_loadPage_withCorrectURl_loadPageCorrectly() {
        let webView = WebViewSpy()
        let sut = SearchAdapter(webView: webView)
        
        sut.loadPage(from: "http://apple.com")
        
        XCTAssertEqual(webView.receivedMessages, [.loadURL("http://apple.com")])
    }
    
    // MARK: - Helpers
    
    private class WebViewSpy: WKWebView {
        enum Message: Equatable {
            case loadURL(String)
        }
        
        var receivedMessages = [Message]()
        
        override func load(_ request: URLRequest) -> WKNavigation? {
            super.load(request)
            receivedMessages.append(.loadURL(request.url!.absoluteString))
            
            return nil
        }
    }
}
