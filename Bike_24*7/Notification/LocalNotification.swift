//
//  LocalNotification.swift
//  Bike_24*7
//
//  Created by Capgemini-DA161 on 12/14/22.
//
import Foundation
import UserNotifications

public class LocalNotificationClass: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    public override init() {
    }
    
    public func receiveNotification(itemName: String) {
        
        notificationCenter.delegate = self
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Order Successful!"
        notificationContent.body = "Your order for \(itemName) has been successfully placed"
        notificationContent.badge = NSNumber(value: 1)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Notificarion Error:", error)
            }
        }
    }
}
