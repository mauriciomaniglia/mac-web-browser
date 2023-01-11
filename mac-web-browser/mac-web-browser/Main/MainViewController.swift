//
//  MainViewController.swift
//  mac-web-browser
//
//  Created by Mauricio Cesar on 12/09/22.
//

import Cocoa
import WebKit

public class MainViewController: NSViewController {
    public var didSendText: ((String) -> Void)?

    let webView = WKWebView()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        setupConstraints()        
    }
    
    private func setupConstraints() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
