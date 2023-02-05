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
        webViewProxy.delegate = windowViewAdapter
        mainWindowController.toolbarDelegate.delegate = windowViewAdapter
        windowPresenter.didUpdatePresentableModel = mainWindowController.updateViews(_:)

        windowPresenter.didStartNewWindow()
    }
}
