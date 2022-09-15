//
//  MainViewController.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 12/09/22.
//

import Cocoa
import WebKit

class MainViewController: NSViewController {
    let searchBar = NSTextField()
    let webView = WKWebView()

    override func viewDidLoad() {
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
        searchBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: searchBar.topAnchor).isActive = true
    }
    
    private func loadWebView(_ string: String) {
        let myURL = URL(string:string)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension MainViewController: NSTextFieldDelegate {
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if (commandSelector == #selector(NSResponder.insertNewline(_:))) {
            loadWebView(textView.string)
            return true
        }
        return false
    }
}
