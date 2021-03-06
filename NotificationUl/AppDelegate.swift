//
//  AppDelegate.swift
//  NotificationUl
//
//  Created by neal on 2017/9/12.
//  Copyright © 2017年 neal. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert ,.sound,.badge]) { (accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        //
        let action = UNNotificationAction(identifier: "remindLater", title: "remind me later", options: [])
        let category = UNNotificationCategory(identifier: "normal", actions: [action], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        return true
    }

    //
    func scheduleNotification(at date: Date) {
        UNUserNotificationCenter.current().delegate = self
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        
        let newComponents = DateComponents.init(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        //
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "Coding Reminder"
        content.body = "Ready to code? let us do some swift!"
        content.sound = UNNotificationSound.default()
        content.categoryIdentifier = "normal"
        
        if let path = Bundle.main.path(forResource: "Swift", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "Swift", url: url, options: nil
                )
                content.attachments = [attachment]
            } catch  {
                print("the attachment was not loaded.")
            }
        }
        
        //
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error:" + error.localizedDescription)
            }
        }
    }

}

extension AppDelegate : UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindLater" {
            let newDate = Date(timeInterval: 60, since: Date())
            scheduleNotification(at: newDate)
        }
    }
}

