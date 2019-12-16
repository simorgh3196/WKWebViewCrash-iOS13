//
//  WebNavigationController.swift
//  WKWebViewCrash-iOS13
//
//  Created by Tomoya Hayakawa on 2019/12/13.
//  Copyright © 2019 simorgh3196. All rights reserved.
//

import UIKit
import WebKit

class WebNavigationController: UINavigationController {

    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        gesture.delegate = self
        return gesture
    }()
    private var lastTappedPoint: CGPoint = .zero

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }

    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if #available(iOS 13, *), viewControllerToPresent is UIDocumentMenuViewController {
            viewControllerToPresent.popoverPresentationController?.delegate = self
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        // 最後にタップした位置を保持する
        lastTappedPoint = sender.location(in: view)
    }
}

extension WebNavigationController: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // 最前面のViewControllerにgestureを付け替える
        tapGesture.view?.removeGestureRecognizer(tapGesture)
        viewController.view.addGestureRecognizer(tapGesture)
    }
}

extension WebNavigationController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // UITapGestureRecognizerが受け取ったタップイベントを透過させる
        return true
    }
}

extension WebNavigationController: UIPopoverPresentationControllerDelegate {

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        // PopoverされるViewの設定
        popoverPresentationController.sourceView = view
        popoverPresentationController.sourceRect = CGRect(origin: lastTappedPoint, size: .zero)
        popoverPresentationController.permittedArrowDirections = [.up, .down]
    }
}
