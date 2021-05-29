//
//  UIWindowExtension.swift
//  ipinfo
//
//  Created by Oleksandr Vasildzhahaz on 29.05.2021.
//

import UIKit

extension UIWindow {
    func replaceRootViewController(with viewController: UIViewController,
                                   completion: VoidCallback? = nil) {
        guard rootViewController != nil else {
            rootViewController = viewController
            return
        }
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.duration = 0.5

        let previousVC = rootViewController
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            previousVC?.removeFromParent()
            previousVC?.view.removeFromSuperview()
            completion?()
        }
        layer.add(transition,
                  forKey: kCATransition)
        rootViewController = viewController
    }

    var presentingController: UIViewController? {
        guard let navigation = rootViewController as? UINavigationController else {
            return rootViewController
        }
        return topViewController(for: navigation)
    }

    func topViewController(for navigationController: UINavigationController) -> UIViewController? {
        guard let presentedNavigation = navigationController.presentedViewController as? UINavigationController else {
            return navigationController.topViewController
        }
        return topViewController(for: presentedNavigation)
    }

}

extension UIWindow: RootPresenter {
    func present(_ presentable: RootPresentable) {
        guard let vc = presentable as? UIViewController else { fatalError("Attempt to present not view controller.") }
        replaceRootViewController(with: vc)
    }
}
