//
//  BrowserViewController.swift
//  WKWebViewCrash-iOS13
//
//  Created by Tomoya Hayakawa on 2019/12/13.
//  Copyright © 2019 simorgh3196. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {

    private lazy var webView = WKWebView()

    override func loadView() {
        super.loadView()

        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(close))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.loadHTMLString("""
        <!DOCTYPE html>
        <html>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <body>
                <h1>Upload icon image</h1>

                <p>Crash when would to select image in modal of page sheet style at iOS13</p>

                <form action="/image_upload.php">
                    <input type="file" name="icon" accept="image/*">
                    <input type="submit">
                </form>
            </body>
        </html>
        """, baseURL: nil)
    }

    @objc private func close() {
        dismiss(animated: true)
    }
}
