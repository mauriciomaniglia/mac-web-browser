import Cocoa
import core_web_browser

public final class WindowToolbar: NSObject, NSToolbarDelegate {
    public var delegate: WindowViewContract?

    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == NSToolbarItem.Identifier("toolbarBackItem") {
            let toolbarItem = MainToolbarFactory.backItem(itemIdentifier)
            toolbarItem.action = #selector(didTapBackButton)
            toolbarItem.target = self
            return toolbarItem
        }

        if itemIdentifier == NSToolbarItem.Identifier("toolbarFowardItem") {
            let toolbarItem = MainToolbarFactory.forwardItem(itemIdentifier)
            toolbarItem.action = #selector(didTapForwardButton)
            toolbarItem.target = self
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

extension WindowToolbar: NSSearchFieldDelegate {
    public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            delegate?.didRequestSearch(textView.string)            
            return true
        }
        return false
    }
}
