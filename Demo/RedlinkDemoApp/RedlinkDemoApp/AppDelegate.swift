//
//  AppDelegate.swift
//  RedlinkDemoApp
//
//  Created by Michal Banaszynski on 05/07/2019.
//  Copyright © 2019 Redlink. All rights reserved.
//

import UIKit
import Redlink

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var didRegisterDeviceToken: ((String?) -> Void)? {
        didSet {
            didRegisterDeviceToken?(deviceToken)
        }
    }
    var deviceToken: String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        Here you can use default configuration
//        to let Redlink handle all the necessary work
//        for you.
//        If you want to do it by yourself please look at the
//        delegate methods down below.
//        NOTE: Default configuration might cause some unexpected
//        issues when Redlink is being used along with Firebase
//        within the same project.
        let config = RedlinkConfiguration.defaultConfiguration()
        config.isLoggingEnabled = true
        Redlink.configure(using: config)
        Redlink.push.registerForPushNotifications(with: RedlinkPushOptions.default())
        
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        Redlink.push.didRegisterForRemoteNotifications(with: deviceToken)
//        UNUserNotificationCenter.current().delegate = self
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02.2hhx", $1)})
        if didRegisterDeviceToken == nil {
            self.deviceToken = tokenString
        } else {
            didRegisterDeviceToken?(tokenString)
        }
    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        Redlink.push.didFailToRegisterForRemoteNotifications(with: error)
//    }
}

// MARK: - UNUserNotificationCenterDelegate
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler(Redlink.push.willPresentNotification(notification, presentationOptions: []))
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        Redlink.push.didReceiveNotificationResponse(response: response)
//    }
//}
