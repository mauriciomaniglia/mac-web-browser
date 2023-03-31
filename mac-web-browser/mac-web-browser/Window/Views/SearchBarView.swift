import AppKit

final class SearchBarView: NSView {
    let searchField: NSSearchField = {
        let searchField = NSSearchField()
        searchField.placeholderString = "Search or enter website name"
        return searchField
    }()

    let progressIndicator: NSProgressIndicator = {
        let progressIndicator = NSProgressIndicator()
        progressIndicator.maxValue = 1.0
        progressIndicator.minValue = 0.0
        progressIndicator.isHidden = true
        progressIndicator.isIndeterminate = false
        return progressIndicator
    }()

    convenience init() {
        self.init(frame: .init(origin: .init(x: 0, y: 0), size: .init(width: 400, height: 50)))
        addSubview(searchField)
        addSubview(progressIndicator)
        setupConstraints()
    }

    private func setupConstraints() {
        searchField.translatesAutoresizingMaskIntoConstraints = false
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([            
            searchField.topAnchor.constraint(equalTo: topAnchor),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchField.bottomAnchor.constraint(equalTo: bottomAnchor),

            progressIndicator.heightAnchor.constraint(equalToConstant: 2),            
            progressIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
