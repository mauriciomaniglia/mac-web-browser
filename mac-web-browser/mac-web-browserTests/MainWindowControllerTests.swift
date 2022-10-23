//
//  MainWindowControllerTests.swift
//  mac-web-browserTests
//
//  Created by Mauricio Cesar on 25/09/22.
//

import XCTest
import mac_web_browser

class MainWindowControllerTests: XCTestCase {
    func test_controlTextViewDoCommandBy_whenPressEnter_sendsCorrectText() {
        let sut = MainWindowController()

        var receivedText: String?
        sut.didSendText = { receivedText = $0 }
        _ = sut.control(NSControl(), textView: anyTextView("http://some-url.com"), doCommandBy: #selector(NSResponder.insertNewline(_:)))

        XCTAssertEqual(receivedText, "http://some-url.com")
    }
    
    // MARK: Helpers

    private func anyTextView(_ string: String) -> NSTextView {
        let textView = NSTextView()
        textView.string = string
        return textView
    }
}
