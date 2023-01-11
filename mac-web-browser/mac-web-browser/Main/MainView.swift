import Cocoa
import WebKit

public class MainView: NSView {
    let webView = WKWebView()

    convenience init() {
        self.init(frame: .init(origin: .init(x: 0, y: 0),
                               size: .init(width: 1000, height: 500)))
        addSubview(webView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
