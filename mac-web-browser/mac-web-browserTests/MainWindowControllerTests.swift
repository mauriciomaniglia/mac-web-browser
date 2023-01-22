import XCTest
import mac_web_browser

class MainWindowControllerTests: XCTestCase {
    func test_controlTextViewDoCommandBy_whenPressEnter_sendsCorrectText() {
        let delegate = MainViewDelegateSpy()
        let sut = MainWindowController()
        sut.delegate = delegate

        _ = sut.control(NSControl(), textView: anyTextView("http://some-url.com"), doCommandBy: #selector(NSResponder.insertNewline(_:)))

        XCTAssertEqual(delegate.receivedMessages, [.didSendText("http://some-url.com")])
    }
    
    // MARK: Helpers

    private class MainViewDelegateSpy: MainViewProtocol {
        enum Message: Equatable {
            case didSendText(_ text: String)
            case didTapBackButton
            case didTapForwardButton
        }

        var receivedMessages = [Message]()

        func didSendText(_ text: String) {
            receivedMessages.append(.didSendText(text))
        }

        func didTapBackButton() {
            receivedMessages.append(.didTapBackButton)
        }

        func didTapForwardButton() {
            receivedMessages.append(.didTapForwardButton)
        }
    }

    private func anyTextView(_ string: String) -> NSTextView {
        let textView = NSTextView()
        textView.string = string
        return textView
    }
}
