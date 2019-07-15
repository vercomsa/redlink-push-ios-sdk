//
//  UIViewController+Alert.swift
//  RedlinkDemoApp
//
//  Created by Michal Banaszynski on 08/07/2019.
//  Copyright © 2019 Redlink. All rights reserved.
//

import UIKit
import UserNotifications

extension UIViewController {

    func checkPushNotificationsAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { [weak self] settings in
            if settings.authorizationStatus == .notDetermined {
                // Notification permission has not been asked yet, go for it!
            } else if settings.authorizationStatus == .denied {
                self?.presentAlertController(title: "Push Notifications not authorized. Go to Settings app and enable them.")
                // Notification permission was previously denied, go to settings & privacy to re-enable
            } else if settings.authorizationStatus == .authorized {
                // Notification permission was already granted
            }
        })
    }
    
    private func presentAlertController(title: String, message: String? = nil, completionBlock: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
            completionBlock?()
        }
    }
}
