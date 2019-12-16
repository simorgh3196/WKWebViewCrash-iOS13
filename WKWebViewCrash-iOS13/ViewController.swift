//
//  ViewController.swift
//  WKWebViewCrash-iOS13
//
//  Created by Tomoya Hayakawa on 2019/12/13.
//  Copyright © 2019 simorgh3196. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let fullScreenStyleButton = UIButton(type: .system)
        fullScreenStyleButton.setTitle("show browser in full screen style", for: .normal)
        fullScreenStyleButton.addTarget(self, action: #selector(didTapFullScreenStyleButton), for: .touchUpInside)

        let pageSheetStyleButton = UIButton(type: .system)
        pageSheetStyleButton.setTitle("show browser in page sheet style", for: .normal)
        pageSheetStyleButton.addTarget(self, action: #selector(didTapPageSheetStyleButton), for: .touchUpInside)

        let fixedPageSheetStyleButton = UIButton(type: .system)
        fixedPageSheetStyleButton.setTitle("show browser in page sheet style", for: .normal)
        fixedPageSheetStyleButton.addTarget(self, action: #selector(didTapFixedPageSheetStyleButton), for: .touchUpInside)

        let containerView = UIStackView(arrangedSubviews: [
            fullScreenStyleButton,
            pageSheetStyleButton,
            fixedPageSheetStyleButton
        ])
        containerView.axis = .vertical

        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc private func didTapFullScreenStyleButton() {
        let browserViewController = BrowserViewController()
        let navigationController = UINavigationController(rootViewController: browserViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }

    @objc private func didTapPageSheetStyleButton() {
        let browserViewController = BrowserViewController()
        let navigationController = UINavigationController(rootViewController: browserViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }

    @objc private func didTapFixedPageSheetStyleButton() {
        let browserViewController = BrowserViewController()
        let navigationController = WebNavigationController(rootViewController: browserViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
}
