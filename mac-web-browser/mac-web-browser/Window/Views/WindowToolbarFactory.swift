import Foundation
import AppKit

final class WindowToolbarFactory {
    static func toolbar() -> NSToolbar {
        let toolbar = NSToolbar(identifier: "MainWindowToolbar")
        toolbar.allowsUserCustomization = true
        toolbar.autosavesConfiguration = true
        toolbar.displayMode = .iconOnly
        toolbar.centeredItemIdentifier = NSToolbarItem.Identifier("toolbarSearchItem")
        
        return toolbar
    }
    
    static func backItem(_ identifier: NSToolbarItem.Identifier) -> NSToolbarItem {
        let toolbarItem = NSToolbarItem(itemIdentifier: identifier)        
        toolbarItem.paletteLabel = "Shows the previous page"
        toolbarItem.toolTip = "Hold to show the history"
        toolbarItem.isBordered = true
        toolbarItem.image = NSImage(systemSymbolName: "chevron.left", accessibilityDescription: "")

        return toolbarItem
    }
    
    static func forwardItem(_ identifier: NSToolbarItem.Identifier) -> NSToolbarItem {
        let toolbarItem = NSToolbarItem(itemIdentifier: identifier)
        toolbarItem.paletteLabel = "Show the next page"
        toolbarItem.toolTip = "Hold to show the history"
        toolbarItem.isBordered = true
        toolbarItem.image = NSImage(systemSymbolName: "chevron.right", accessibilityDescription: "")
        
        return toolbarItem
    }
    
    static func searchItem(_ identifier: NSToolbarItem.Identifier) -> NSToolbarItem {
        let searchBarView = SearchBarView()
        let toolbarItem = NSToolbarItem(itemIdentifier: identifier)
        toolbarItem.paletteLabel = "Search bar"
        toolbarItem.toolTip = "Search or enter website name"
        toolbarItem.view = searchBarView

        return toolbarItem
    }
}
