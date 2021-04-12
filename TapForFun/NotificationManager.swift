//
//  NotificationManager.swift
//  TapForFun
//
//  Created by Alexandra Beznosova on 06/07/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//

import UIKit
import UserNotifications

//class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
//	
//	static let shared = NotificationManager()
//	override private init() {}
//	//MARK: - property to set user notification content
//	let content = UNMutableNotificationContent()
//	var contents: [Advice] = []
//	// The user notification time
//	var hours = [10, 11, 13, 12, 14, 18]
//	var defhour = 10
//	var defmin = 30
//	// MARK: - Localizable strings properties
//	let notifTitle = NSLocalizedString("Words are powerful", comment: "")// add this "Simply remember"
//	let notifSubtitle = NSLocalizedString("Some of it repeat", comment: "")
//	// MARK: - Register UserNotifications
//	func allowUserNotifications() {
//		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
//			if granted {
//				print("Notification granted")
//			} else {
//				print(error?.localizedDescription as Any)
//			}
//		}
//	}
//	// Delegation method
//	func delegate() {
//		UNUserNotificationCenter.current().delegate = self
//	}
//	// Setting up & schedule default user notification content
//	func notifyUser() {
//		//Parse JSON for UserNotification content
//		guard let path = Bundle.main.path(forResource: "quotes", ofType: "json") else { return }
//		let url = URL(fileURLWithPath: path)
//		do {
//			let data = try Data(contentsOf: url)
//			let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
//			let jsonDict = json as! Dictionary<String, Array<String>>
//			for (_ , value) in jsonDict {
//				
//				let one = NotificationModel(title: notifTitle, subtitle: notifSubtitle, body: localizableValue, id: "affirmation", hour: defhour, min: defmin)
//				contents.append(one)
//			}
//		} catch {
//			print("Fatal error: \(error.localizedDescription)")
//		}
//		// Remove all pending notifications
//		let center = UNUserNotificationCenter.current()
//		center.removeAllPendingNotificationRequests()
//		// Setup user notifications
//		for item in contents {
//			var date = DateComponents()
//			date.calendar = Calendar.current
//			date.timeZone = NSTimeZone.system
//			date.hour = item.hour
//			date.minute = item.min
//			content.title = item.title
//			content.subtitle = item.subtitle
//			content.categoryIdentifier = item.id
//			content.body = item.body
//			let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
//			let request = UNNotificationRequest(identifier: item.id, content: content, trigger: trigger)
//			// Add request to UserNotificationCenter
//			center.add(request)  { (error) in
//				if let errorPerforms = error {
//					print("Fatal error: \(errorPerforms.localizedDescription)")
//				} else {
//					print("Success")
//					center.getPendingNotificationRequests { (notifications ) in
//						//print("Count: \(notifications.count)")
//						for item  in notifications {
//							//print(item.content)
//							print("-------------------")
//							guard let trigger = item.trigger as? UNCalendarNotificationTrigger else { continue }
//							print(trigger.nextTriggerDate()!)
//						}
//					}
//				}
//			}
//		}
//	}
//
//} // End class
//
