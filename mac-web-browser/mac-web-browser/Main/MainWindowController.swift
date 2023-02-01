import Cocoa
import core_web_browser

final public class MainWindowController: NSWindowController {
    public var delegate: WindowViewContract?
    
    public override func windowDidLoad(){
        super.windowDidLoad()
        self.configureToolbar()
    }

    private func configureToolbar() {
        if let window = self.window {
            let toolbar = MainToolbarFactory.toolbar()
            toolbar.delegate = self
            window.toolbarStyle = .unified
            window.titleVisibility = .hidden
            window.toolbar = toolbar
            window.toolbar?.validateVisibleItems()
        }
    }
}

extension MainWindowController: NSToolbarDelegate {
    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == NSToolbarItem.Identifier("toolbarBackItem") {
            let toolbarItem = MainToolbarFactory.backItem(itemIdentifier)            
            toolbarItem.action = #selector(didTapBackButton)
            return toolbarItem
        }
        
        if itemIdentifier == NSToolbarItem.Identifier("toolbarFowardItem") {
            let toolbarItem = MainToolbarFactory.forwardItem(itemIdentifier)
            toolbarItem.action = #selector(didTapForwardButton)
            return toolbarItem
        }
        
        if itemIdentifier == NSToolbarItem.Identifier("toolbarSearchItem") {
            let searchItem = MainToolbarFactory.searchItem(itemIdentifier)
            searchItem.searchField.delegate = self
            return searchItem
        }
        
        return nil
    }
    
    public func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            NSToolbarItem.Identifier("toolbarBackItem"),
            NSToolbarItem.Identifier("toolbarFowardItem"),
            NSToolbarItem.Identifier("toolbarSearchItem")
        ]
    }
    
    public func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return []
    }

    @objc private func didTapBackButton() {
        delegate?.didTapBackButton()
    }

    @objc private func didTapForwardButton() {
        delegate?.didTapForwardButton()
    }
}

extension MainWindowController: NSSearchFieldDelegate {
    public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            delegate?.didRequestSearch(textView.string)
            return true
        }
        return false
    }
}
