import Foundation
import WebKit
import core_web_browser

public final class MainViewAdapter: MainViewProtocol {
    let webView: WKWebView
    
    public init(webView: WKWebView) {
        self.webView = webView
    }

    public func didSendText(_ text: String) {
        webView.load(URLRequest(url: SearchURLBuilder.makeURL(from: text)))
    }

    public func didTapBackButton() {
        webView.goBack()
    }

    public func didTapForwardButton() {
        webView.goForward()
    }
}
