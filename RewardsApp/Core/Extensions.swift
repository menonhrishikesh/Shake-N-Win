//
//  Extensions.swift
//  RewardsApp
//
//  Created by flock on 07/01/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presentedController = top?.presentedViewController {
                top = presentedController
            } else if let navController = top as? UINavigationController {
                top = navController.visibleViewController
            } else if let tabController = top as? UITabBarController {
                top = tabController.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

extension UIView {
    func addBorder(width: CGFloat = 1, color: UIColor = .black) {
        self.layer.borderWidth  = width
        self.layer.borderColor  = color.cgColor
    }
    
    func showShakeAnimation(completion: @escaping CompletionHandler) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y - 10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y + 10))
        
        self.layer.add(animation, forKey: "position")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion()
        }
    }
}

extension UIImageView {
    func loadImage(from urlString: String?, placeholderImage: UIImage?, onSuccess: @escaping CompletionHandler, onFailure: @escaping CompletionHandler) {
        if urlString != nil, let url  = URL(string: urlString!) {
            self.sd_setImage(with: url, placeholderImage: placeholderImage) { (image, error, cache, urls) in
                if (error != nil) {
                    // Failed to load image
                    onFailure()
                } else {
                    // Successful in loading image
                    onSuccess()
                }
            }
        } else {
            onFailure()
        }
    }
}
