import AppKit

final class MainComposer {
    static func composerWebView() {
        let mainWindowController = NSApplication.shared.windows.first?.windowController as! MainWindowController
        let mainView = MainView()
        let searchAdapter = SearchAdapter(webView: mainView.webView)

        mainWindowController.contentViewController?.view = mainView
        mainWindowController.delegate = searchAdapter
    }
}
