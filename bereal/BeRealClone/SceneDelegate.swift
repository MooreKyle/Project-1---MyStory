//
//  SceneDelegate.swift
//  BeRealClone
//
//  Created by Mari Batilando on 10/25/22.
//

import UIKit
import ParseSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    NotificationCenter.default.addObserver(forName: Notification.Name("login"),
                                           object: nil,
                                           queue: .main) { [unowned self] notification in
      self.login()
    }
    
    NotificationCenter.default.addObserver(forName: Notification.Name("logout"),
                                           object: nil,
                                           queue: .main) { [unowned self] notification in
      self.logout()
    }
    
    if User.current != nil {
      self.login()
    }
  }
  
  private func login() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "PostFeedNav")
    requestNotificationPermissionIfNeeded()
  }
  
  private func logout() {
    User.logout { [unowned self] result in
      switch result {
      case .success:
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "Login")
        self.unregisterLocalNotifications()
      case .failure(let error):
        print("Logout error: \(error)")
      }
    }
  }
  
  private func requestNotificationPermissionIfNeeded() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { [unowned self] isGranted, error in
      guard isGranted else {
        print("User didn't grant notifications permission")
        return
      }
      self.registerLocalNotifications()
    }
  }
  
  private func registerLocalNotifications() {
    let content = UNMutableNotificationContent()
    content.title = "BeReal"
    content.body = "Remember to upload today's photo!"
    let tomorrow = TimeInterval(60 * 60 * 24)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: tomorrow, repeats: true)
    let request = UNNotificationRequest(identifier: "PostReminderNotification",
                                        content: content,
                                        trigger: trigger)
    UNUserNotificationCenter.current().add(request) { error in
       if let error = error {
         print("Error when registering for notification \(error.localizedDescription)")
       }
    }
  }
  
  private func unregisterLocalNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
  
  
}

