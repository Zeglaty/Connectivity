/*
 * Copyright 2017 Google
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit
import UserNotifications

import FirebaseMessaging

// MARK: - Decleration
enum NotificationsControllerAllowedNotificationType: String {
  case none = "None"
  case silent = "Silent Updates"
  case alert = "Alerts"
  case badge = "Badges"
  case sound = "Sounds"
}

let APNSTokenReceivedNotification: Notification.Name
  = Notification.Name(rawValue: "APNSTokenReceivedNotification")
let UserNotificationsChangedNotification: Notification.Name
  = Notification.Name(rawValue: "UserNotificationsChangedNotification")

class NotificationsController: NSObject {
    
    var window: UIWindow?
    
  static let shared: NotificationsController = {
    let instance = NotificationsController()
    return instance
  }()
    
    
    
    
    


// MARK: - Configration
  class func configure() {
    let sharedController = NotificationsController.shared
    // Always become the delegate of UNUserNotificationCenter, even before we've requested user
    // permissions
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = sharedController
    }
  }

  func registerForUserFacingNotificationsFor(_ application: UIApplication) {
    
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .badge, .sound],
                              completionHandler: { granted, error in
                                NotificationCenter.default
                                  .post(name: UserNotificationsChangedNotification, object: nil)
                              })
    } else if #available(iOS 8.0, *) {
      let userNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                                categories: [])
      application.registerUserNotificationSettings(userNotificationSettings)

    } else {
      application.registerForRemoteNotifications(matching: [.alert, .badge, .sound])
    }
  }

}










// MARK: - Receving NoteficationsData,
//UNUserNotificationCenterDelegate
//1 - these methods will handel receving Notifications
//2 - and from hear you can dirct the user to ascreen

@available(iOS 10.0, *)
extension NotificationsController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler:
                              @escaping (UNNotificationPresentationOptions) -> Void) {
    // Always show the incoming notification, even if the app is in foreground
    //- extracting data
    print("Received notification in foreground:")
    let jsonString = notification.request.content.userInfo.jsonString ?? "{}"
    print("\(jsonString)")
    completionHandler([.alert, .badge, .sound])
    
    
  }

//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping () -> Void) {
//    //- extracting data
//    print("Received notification response")
//    let jsonString = response.notification.request.content.userInfo.jsonString ?? "{}"
//    print("\(jsonString)")
//
//
//    //- navegating to a screen
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//    self.window?.rootViewController = vc
//
//    completionHandler()
//  }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        //- extracting data
       print("Received notification response")
       let jsonString = response.notification.request.content.userInfo.jsonString ?? "{}"
       print("\(jsonString)")


        //- navegating to a screen

        // retrieve the root view controller (which is a tab bar controller)
        if #available(iOS 13.0, *) {

            guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController else {
                return
            }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            // instantiate the view controller we want to show from storyboard
            // root view controller is tab bar controller
            // the selected tab is a navigation controller
            // then we push the new view controller to it
            if  let conversationVC = storyboard.instantiateViewController(withIdentifier: "SubSubScreenViewController") as? SubSubScreenViewController,
                let tabBarController = rootViewController as? UITabBarController,
                let navController = tabBarController.selectedViewController as? UINavigationController {

                    // we can modify variable of the new view controller using notification data
                    // (eg: title of notification)
//                    conversationVC.senderDisplayName = response.notification.request.content.title

                    // you can access custom data of the push notification by using userInfo property
                    // response.notification.request.content.userInfo
                    navController.pushViewController(conversationVC, animated: true)
            }






        } else {
            // Fallback on earlier versions

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
                self.window?.rootViewController = vc
        }



        // tell the app that we have finished processing the user’s action / response
        completionHandler()
    }
    

}
