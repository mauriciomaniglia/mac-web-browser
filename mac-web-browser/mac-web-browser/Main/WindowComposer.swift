import AppKit
import core_web_browser

final class WindowComposer {
    static func composerWebView() {
        let windowController = NSApplication.shared.windows.first?.windowController as! WindowController
        let view = WindowView()
        let webViewProxy = WebViewProxy(webView: view.webView)
        let windowPresenter = WindowPresenter()
        let windowViewAdapter = WindowViewAdapter(webViewProxy: webViewProxy, presenter: windowPresenter)

        windowController.contentViewController?.view = view
        webViewProxy.delegate = windowViewAdapter
        windowController.toolbarDelegate.delegate = windowViewAdapter
        windowPresenter.didUpdatePresentableModel = windowController.updateViews(_:)

        windowPresenter.didStartNewWindow()
    }
}
