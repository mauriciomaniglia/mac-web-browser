import Cocoa
import core_web_browser

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        WindowComposer.composerWebView()
    }
}

