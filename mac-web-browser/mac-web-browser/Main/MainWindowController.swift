import Cocoa

final public class MainWindowController: NSWindowController {
    public var didSendText: ((String) -> Void)?
    public var didSelectBackButton: (() -> Void)?
    public var didSelectFowardButton: (() -> Void)?
    
    public override func windowDidLoad(){
        super.windowDidLoad()
        self.configureToolbar()
    }

    private func configureToolbar() {
        if let unwrappedWindow = self.window {
            let toolbar = MainToolbarFactory.toolbar()
            toolbar.delegate = self
            
            unwrappedWindow.toolbarStyle = .unified
            unwrappedWindow.titleVisibility = .hidden
            unwrappedWindow.toolbar = toolbar
            unwrappedWindow.toolbar?.validateVisibleItems()
        }
    }
}

extension MainWindowController: NSToolbarDelegate {
    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == NSToolbarItem.Identifier("toolbarBackItem") {
            let toolbarItem = MainToolbarFactory.backItem(itemIdentifier)            
            toolbarItem.action = #selector(didSelectItem(_:))
            return toolbarItem
        }
        
        if itemIdentifier == NSToolbarItem.Identifier("toolbarFowardItem") {
            let toolbarItem = MainToolbarFactory.forwardItem(itemIdentifier)
            toolbarItem.action = #selector(didSelectItem(_:))            
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
    
    @objc private func didSelectItem(_ sender: NSToolbarItem) {
        switch sender.itemIdentifier.rawValue {
        case "toolbarBackItem":
            didSelectBackButton?()
        case "toolbarFowardItem":
            didSelectFowardButton?()
        default:
            break
        }
    }
}

extension MainWindowController: NSSearchFieldDelegate {
    public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            didSendText?(textView.string)
            return true
        }
        return false
    }
}
