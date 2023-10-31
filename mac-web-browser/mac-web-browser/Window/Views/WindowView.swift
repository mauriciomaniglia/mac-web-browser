import Cocoa

public class WindowView: NSView {
    let webView: NSView

    init(webView: NSView) {
        self.webView = webView
        super.init(frame: .init(origin: .init(x: 0, y: 0), size: .init(width: 1000, height: 500)))
        addSubview(webView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
