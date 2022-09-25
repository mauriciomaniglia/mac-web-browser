//
//  MainViewControllerTests.swift
//  mac-web-browserTests
//
//  Created by Mauricio Cesar on 25/09/22.
//

import XCTest
import mac_web_browser

class MainViewControllerTests: XCTestCase {
    func test_controlTextViewDoCommandBy_whenPressEnter_sendsCorrectText() {
        let delegate = MainViewControllerDelegateSpy()
        let sut = MainViewController()
        sut.delegate = delegate

        _ = sut.control(NSControl(), textView: anyTextView("http://some-url.com"), doCommandBy: #selector(NSResponder.insertNewline(_:)))

        XCTAssertEqual(delegate.receivedMessages, [.sendText("http://some-url.com")])
    }
    
    // MARK: Helpers

    private class MainViewControllerDelegateSpy: MainViewControllerDelegate {
        enum Message: Equatable {
            case sendText(_ text: String)
        }

        var receivedMessages = [Message]()

        func sendText(_ text: String) {
            receivedMessages.append(.sendText(text))
        }
    }

    private func anyTextView(_ string: String) -> NSTextView {
        let textView = NSTextView()
        textView.string = string
        return textView
    }
}
