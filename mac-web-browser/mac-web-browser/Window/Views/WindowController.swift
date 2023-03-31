import Cocoa
import core_web_browser

final public class WindowController: NSWindowController {
    let toolbarDelegate = WindowToolbar()
    
    public override func windowDidLoad(){
        super.windowDidLoad()
        self.configureToolbar()
    }

    private func configureToolbar() {
        if let window = self.window {
            let toolbar = WindowToolbarFactory.toolbar()
            toolbar.delegate = toolbarDelegate
            window.toolbarStyle = .unified
            window.titleVisibility = .hidden
            window.toolbar = toolbar
            window.toolbar?.validateVisibleItems()
        }
    }

    public func updateViews(_ presentableModel: WindowPresentableModel) {
        (contentViewController?.view as? WindowView)?.webView.isHidden = !presentableModel.showWebView
        toolbarDelegate.goBackItem.target = presentableModel.canGoBack ? toolbarDelegate : nil
        toolbarDelegate.goForwardItem.target = presentableModel.canGoForward ? toolbarDelegate : nil

        if let progressBarValue = presentableModel.progressBar, progressBarValue < 1 {
            toolbarDelegate.startProgressBar(progressBarValue)
        } else {
            toolbarDelegate.finishProgressBar()
        }
    }
}
