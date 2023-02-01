import XCTest
import mac_web_browser
import core_web_browser

class MainWindowControllerTests: XCTestCase {
    func test_controlTextViewDoCommandBy_whenPressEnter_sendsCorrectText() {
        let delegate = MainViewDelegateSpy()
        let sut = MainWindowController()
        sut.delegate = delegate

        _ = sut.control(NSControl(), textView: anyTextView("http://some-url.com"), doCommandBy: #selector(NSResponder.insertNewline(_:)))

        XCTAssertEqual(delegate.receivedMessages, [.didRequestSearch("http://some-url.com")])
    }
    
    // MARK: Helpers

    private class MainViewDelegateSpy: WindowViewContract {
        enum Message: Equatable {
            case didRequestSearch(_ text: String)
            case didTapBackButton
            case didTapForwardButton
        }

        var receivedMessages = [Message]()

        func didRequestSearch(_ text: String) {
            receivedMessages.append(.didRequestSearch(text))
        }

        func didStartTyping() {

        }

        func didEndTyping() {

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
