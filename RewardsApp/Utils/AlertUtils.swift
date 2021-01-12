//
//  AlertUtils.swift
//  RewardsApp
//
//  Created by flock on 09/01/21.
//

import Foundation
import UIKit

class AlertUtils: NSObject {
    
    class func showAlert(title: String?, message: String?, leftButtonTitle: String?, leftButtonAction: CompletionHandler? = nil, rightButtonTitle: String? = nil, rightButtonAction: CompletionHandler? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if leftButtonTitle != nil {
            alertController.addAction(UIAlertAction(title: leftButtonTitle, style: .default, handler: { (_) in
                leftButtonAction?()
            }))
        }
        if rightButtonTitle != nil {
            alertController.addAction(UIAlertAction(title: rightButtonTitle, style: .default, handler: { (_) in
                rightButtonAction?()
            }))
        }
        
        if alertController.actions.count > 0 {
            SceneDelegate.shared?.window?.topViewController()?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
