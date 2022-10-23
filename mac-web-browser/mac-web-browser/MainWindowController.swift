//
//  MainWindowController.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 22/10/22.
//

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
            
            let newToolbar = NSToolbar(identifier: "MainWindowToolbar")
            newToolbar.delegate = self
            newToolbar.allowsUserCustomization = true
            newToolbar.autosavesConfiguration = true
            newToolbar.displayMode = .iconOnly
            newToolbar.centeredItemIdentifier = NSToolbarItem.Identifier("toolbarSearchItem")
            
            unwrappedWindow.toolbarStyle = .unified
            unwrappedWindow.titleVisibility = .hidden
            unwrappedWindow.toolbar = newToolbar
            unwrappedWindow.toolbar?.validateVisibleItems()
        }
    }
}

extension MainWindowController: NSToolbarDelegate {
    public func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        if itemIdentifier == NSToolbarItem.Identifier("toolbarBackItem") {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(didSelectItem(_:))
            toolbarItem.paletteLabel = "Shows the previous page"
            toolbarItem.toolTip = "Hold to show the history"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "chevron.left", accessibilityDescription: "")
            return toolbarItem
        }
        
        if itemIdentifier == NSToolbarItem.Identifier("toolbarFowardItem") {
            let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.target = self
            toolbarItem.action = #selector(didSelectItem(_:))
            toolbarItem.paletteLabel = "Show the next page"
            toolbarItem.toolTip = "Hold to show the history"
            toolbarItem.isBordered = true
            toolbarItem.image = NSImage(systemSymbolName: "chevron.right", accessibilityDescription: "")
            return toolbarItem
        }
        
        if itemIdentifier == NSToolbarItem.Identifier("toolbarSearchItem") {
            let searchItem = NSSearchToolbarItem(itemIdentifier: itemIdentifier)
            searchItem.resignsFirstResponderWithCancel = true
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
