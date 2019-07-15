//
//  ViewController.swift
//  RedlinkDemoApp
//
//  Created by Michal Banaszynski on 05/07/2019.
//  Copyright © 2019 Redlink. All rights reserved.
//

import UIKit
import Redlink

class ViewController: UIViewController {

    @IBOutlet private weak var deviceTokenTextField: UITextField!
    @IBOutlet private weak var pushInfoTextView: UITextView!
    @IBOutlet private weak var copyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        (UIApplication.shared.delegate as? AppDelegate)?.didRegisterDeviceToken = { [weak self] token in
            self?.deviceTokenTextField.text = token
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    func appendTextToPushInfoTextView(_ text: String) {
        pushInfoTextView.text = pushInfoTextView.text.appending(text)
        
        // scrolling textView to the bottom edge
        let bottomOffset = CGPoint(x: 0, y: pushInfoTextView.contentSize.height - pushInfoTextView.bounds.size.height)
        pushInfoTextView.setContentOffset(bottomOffset, animated: true)
    }
    
    @IBAction func clearPushInfoTextViewAction(_ sender: Any) {
        pushInfoTextView.text = ""
    }
    
    @IBAction func deviceTokenCopyAction(_ sender: Any) {
        guard let deviceToken = deviceTokenTextField.text, deviceTokenTextField.text?.count ?? 0 > 0 else {
            return checkPushNotificationsAuthorizationStatus()
        }
        let activityViewController = UIActivityViewController(activityItems: [deviceToken], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.copyButton
        DispatchQueue.main.async { [weak self] in
            self?.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    /// Used to generate random event with parameters.
    @IBAction func generateEventPressed(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let eventName = "Generated_event_at_time:_\(dateFormatter.string(from: Date()).replacingOccurrences(of: " ", with: "_"))"
        Redlink.analytics.trackEvent(withName: eventName, parameters: [
            "stringKey": "stringValue",
            "intKey": Int.random(in: 0...100),
            "boolKey": Int.random(in: 0...1) == 0 ? true : false,
            "dateKey": Date()
            ])
    }
    
    /// Used to send event with a given name.
    @IBAction func createEventPressed(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Event", message: nil, preferredStyle: .alert)
            alertController.addTextField { textfield in
                textfield.placeholder = "Event name"
                textfield.tag = 1
            }
            
            let sendAction = UIAlertAction(title: "Send", style: .default) { [weak alertController] _ in
                guard let eventName = alertController?.textFields?.filter({ $0.tag == 1 }).first?.text else { return }
                Redlink.analytics.trackEvent(withName: eventName)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(sendAction)
            alertController.addAction(cancelAction)
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Used to prepare current user's data to be sent do Redlink.
    @IBAction func editUserDataPressed(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            let alertController = UIAlertController(title: "Edit user's data", message: nil, preferredStyle: .alert)
            alertController.addTextField { emailTextField in
                emailTextField.text = Redlink.user.email
                emailTextField.placeholder = "email"
                emailTextField.keyboardType = .emailAddress
                emailTextField.tag = 1
            }
            alertController.addTextField { phoneTextField in
                phoneTextField.text = Redlink.user.phone
                phoneTextField.placeholder = "phone number"
                phoneTextField.keyboardType = .phonePad
                phoneTextField.tag = 2
            }
            alertController.addTextField { firstNameTextField in
                firstNameTextField.text = Redlink.user.firstName
                firstNameTextField.placeholder = "name"
                firstNameTextField.keyboardType = .default
                firstNameTextField.tag = 3
            }
            alertController.addTextField { lastNameTextField in
                lastNameTextField.text = Redlink.user.lastName
                lastNameTextField.placeholder = "surname"
                lastNameTextField.keyboardType = .default
                lastNameTextField.tag = 4
            }
            
            let sendAction = UIAlertAction(title: "Edit", style: .default) { [weak alertController] _ in
                let email = alertController?.textFields?.filter({ $0.tag == 1 }).first?.text
                let phone = alertController?.textFields?.filter({ $0.tag == 2 }).first?.text
                let firstName = alertController?.textFields?.filter({ $0.tag == 3 }).first?.text
                let lastName = alertController?.textFields?.filter({ $0.tag == 4 }).first?.text
                
                Redlink.user.email = email
                Redlink.user.phone = phone
                Redlink.user.firstName = firstName
                Redlink.user.lastName = lastName
                Redlink.user.saveUser()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alertController.addAction(sendAction)
            alertController.addAction(cancelAction)
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        preparePushInfoText(actionType: "💌 Recieved Notification: 💌", userInfo: userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let actionId = response.actionIdentifier
        
        if actionId == UNNotificationDefaultActionIdentifier {
            preparePushInfoText(actionType: "🍻 Opened Notification: 🍻", userInfo: userInfo)
        } else {
            preparePushInfoText(actionType: "👇🏿 Tapped on Action: \"\(actionId)\"👇🏿", userInfo: userInfo)
        }
    }
    
    /// Simple formatter for incomming user info to get string representation for presentation purposes.
    private func preparePushInfoText(actionType: String, userInfo: [AnyHashable: Any]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .long
        
        let currentTime = dateFormatter.string(from: Date())
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            let pushString = (String(bytes: jsonData, encoding: String.Encoding.utf8) ?? "")
            appendTextToPushInfoTextView("🕰 \(currentTime) 🕰\n\(actionType)\n\(pushString)\n\n")
        } catch {
            appendTextToPushInfoTextView("\n🕰 \(currentTime) 🕰\n☠️ Error ☠️: \(error.localizedDescription)\n\n")
        }
    }
}
