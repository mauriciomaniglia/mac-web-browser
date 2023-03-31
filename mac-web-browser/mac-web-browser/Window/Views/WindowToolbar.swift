import Cocoa
import core_web_browser

public final class WindowToolbar: NSObject, NSToolbarDelegate {
    public var delegate: WindowViewContract?
    public let goBackItem: NSToolbarItem
    public let goForwardItem: NSToolbarItem
    public let searchItem: NSToolbarItem

    private let goBackItemIdentifier = "toolbarBackItem"
    private let goForwardItemIdentifier = "toolbarFowardItem"
    private let searchItemIdentifier = "toolbarSearchItem"

    public override init() {
        goBackItem = WindowToolbarFactory.backItem(.init(goBackItemIdentifier))
        goForwardItem = WindowToolbarFactory.forwardItem(.init(goForwardItemIdentifier))
        searchItem = WindowToolbarFactory.searchItem(.init(searchItemIdentifier))
        super.init()
        setupToolbarItems()
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

    public func updateProgressBar(_ value: Double?) {
        let searchBarView = searchItem.view as? SearchBarView

        if let value = value, value < 1 {
            searchBarView?.progressIndicator.doubleValue = value
            searchBarView?.progressIndicator.isHidden = false
        } else {
            searchBarView?.progressIndicator.isHidden = true
        }
    }

    private func setupToolbarItems() {
        goBackItem.action = #selector(didTapBackButton)
        goBackItem.target = self
        goForwardItem.action = #selector(didTapForwardButton)
        goForwardItem.target = self

        let searchBarView = searchItem.view as? SearchBarView
        searchBarView?.searchField.delegate = self
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
