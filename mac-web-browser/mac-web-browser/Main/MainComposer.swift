import AppKit
import core_web_browser

final class MainComposer {
    static func composerWebView() {
        let mainWindowController = NSApplication.shared.windows.first?.windowController as! MainWindowController
        let mainView = MainView()
        let webViewProxy = WebViewProxy(webView: mainView.webView)
        let windowPresenter = WindowPresenter()
        let windowViewAdapter = WindowViewAdapter(webViewProxy: webViewProxy, presenter: windowPresenter)

        mainWindowController.contentViewController?.view = mainView
        mainWindowController.delegate = windowViewAdapter
    }
}
