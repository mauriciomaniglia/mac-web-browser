import Cocoa
import core_web_browser

public final class WindowToolbar: NSObject, NSToolbarDelegate {
    public var delegate: WindowViewContract?
    public let goBackItem: NSToolbarItem
    public let goForwardItem: NSToolbarItem
    public let searchItem: NSSearchToolbarItem

    private let goBackItemIdentifier = "toolbarBackItem"
    private let goForwardItemIdentifier = "toolbarFowardItem"
    private let searchItemIdentifier = "toolbarSearchItem"

    public override init() {
        goBackItem = MainToolbarFactory.backItem(.init(goBackItemIdentifier))
        goForwardItem = MainToolbarFactory.forwardItem(.init(goForwardItemIdentifier))
        searchItem = MainToolbarFactory.searchItem(.init(searchItemIdentifier))
        super.init()
        setupToolbarItems()
    }

    private func setupToolbarItems() {
        goBackItem.action = #selector(didTapBackButton)
        goBackItem.target = self
        goForwardItem.action = #selector(didTapForwardButton)
        goForwardItem.target = self
        searchItem.searchField.delegate = self
    }

    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == .init(goBackItemIdentifier) { return goBackItem }
        if itemIdentifier == .init(goForwardItemIdentifier) { return goForwardItem }
        if itemIdentifier == .init(searchItemIdentifier) { return searchItem }
        return nil
    }

    public func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [
            .init(goBackItemIdentifier),
            .init(goForwardItemIdentifier),
            .init(searchItemIdentifier)
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
