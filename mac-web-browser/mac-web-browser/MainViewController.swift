//
//  MainViewController.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 12/09/22.
//

import Cocoa
import WebKit

public protocol MainViewControllerDelegate {
    func sendText(_ text: String)
}

public class MainViewController: NSViewController {
    public var delegate: MainViewControllerDelegate?

    let searchBar = NSTextField()
    let webView = WKWebView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchBar)
        view.addSubview(webView)
        searchBar.delegate = self
        setupConstraints()
        loadWebView("http:google.com")
    }
    
    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func loadWebView(_ string: String) {
        let myURL = URL(string:string)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension MainViewController: NSTextFieldDelegate {
    public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {            
            delegate?.sendText(textView.string)
            return true
        }
        return false
    }
}
