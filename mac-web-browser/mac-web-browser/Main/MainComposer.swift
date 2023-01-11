import AppKit

final class MainComposer {
    static func composerWebView() {
        let mainWindowController = NSApplication.shared.windows.first?.windowController as! MainWindowController
        let contentViewController = mainWindowController.contentViewController as! MainViewController
        let searchAdapter = SearchAdapter(webView: contentViewController.webView)
        
        mainWindowController.didSendText = searchAdapter.loadPage(from:)
    }
}
