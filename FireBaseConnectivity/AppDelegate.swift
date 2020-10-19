//
//  AppDelegate.swift
//  FireBaseConnectivity
//
//  Created by AbdalmagidNew on 10/18/20.
//

import UIKit

import Firebase
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // 1 - Configring Firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        
        // 2 - Regestering for Notifcations
        NotificationsController.configure()
        NotificationsController.shared.registerForUserFacingNotificationsFor(UIApplication.shared)
        application.registerForRemoteNotifications()
        
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


// MARK: - User Notifications
extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS Token: \(deviceToken.hexEncodedString())")

        NotificationCenter.default.post(name: APNSTokenReceivedNotification, object: nil)
        NotificationCenter.default.post(name: UserNotificationsChangedNotification, object: nil)
    }
    
//--------
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)-> Void) {
      print(
        "application:didReceiveRemoteNotification:fetchCompletionHandler: called, with notification:"
      )
      print("\(userInfo.jsonString ?? "{}")")
      completionHandler(.newData)
    }
    
//-------
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
      let userInfo = notification.request.content.userInfo

      // With swizzling disabled you must let Messaging know about the message, for Analytics
       Messaging.messaging().appDidReceiveMessage(userInfo)
      // Change this to your preferred presentation option
      completionHandler([.alert, .sound, .badge])
      

      
    }
    
    
}



// MARK: - Messaging
extension AppDelegate: MessagingDelegate {
  // 1 - FCM tokens are always provided here.
  // 2 - It is called generally during app start, but may be called more than once
  // 3 - if the token is invalidated or updated. This is the right spot to upload this
  // token to your application server, or to subscribe to any topics.
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    if let token = Messaging.messaging().fcmToken {
      print("FCM Token: \(token)")
    } else {
      print("FCM Token: nil")
    }
  }


}

//// Firebase DirectMessages ( that are not connected throw the APNs )
//// this method will notifiy you when you have a connection with this service
//// it is not an important fether
//// call "listenForDirectChannelStateChanges()" in "appDeleget/didFinishLaunchingWithOptions" if you need it
//extension AppDelegate {
//  func listenForDirectChannelStateChanges() {
//    NotificationCenter.default
//      .addObserver(self, selector: #selector(onMessagingDirectChannelStateChanged(_:)),
//                   name: .MessagingConnectionStateChanged, object: nil)
//  }
//
//    @objc func onMessagingDirectChannelStateChanged(_ notification: Notification) {
//    print("FCM Direct Channel Established: \(Messaging.messaging().isDirectChannelEstablished)")
//  }
//}





// MARK: - pretty-print JSON
extension Dictionary {
  /// Utility method for printing Dictionaries as pretty-printed JSON.
  var jsonString: String? {
    if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]),
      let jsonString = String(data: jsonData, encoding: .utf8) {
      return jsonString
    }
    return nil
  }
}
extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
