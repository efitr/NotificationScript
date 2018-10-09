
//  Here are all the scripts that we will be adding to the project, until at the end we get a working project.

//1.
import UIKit
import UserNotifications



////2.
//func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//    print("APNs device token: \(deviceTokenString)")
//}
//
//func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//    print("APNs registration failed: \(error)")
//}



////3.
//func registerForPushNotifications() {
//    UNUserNotificationCenter.current().delegate = (self as UNUserNotificationCenterDelegate)
//    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//        (granted, error) in
//        print("Permission granted: \(granted)")
//        // 1. Check if permission granted
//        guard granted else { return }
//        // 2. Attempt registration for remote notifications on the main thread
//        DispatchQueue.main.async {
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
//}



////4.
//func configureNotification() {
//    if #available(iOS 10.0, *) {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
//    }
//    UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//
//    UIApplication.shared.registerForRemoteNotifications()
//}



////5. How your app delegate should look if you have followed every step
//
//import UIKit
//import UserNotifications
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
//
//    var window: UIWindow?
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        self.configureNotification()
//        return true
//    }
//
//    func applicationWillResignActive(_ application: UIApplication) {
//    }
//
//    func applicationDidEnterBackground(_ application: UIApplication) {
//    }
//
//    func applicationWillEnterForeground(_ application: UIApplication) {
//    }
//
//    func applicationDidBecomeActive(_ application: UIApplication) {
//    }
//
//    func applicationWillTerminate(_ application: UIApplication) {
//    }
//
//    func configureNotification() {
//        if #available(iOS 10.0, *) {
//            let center = UNUserNotificationCenter.current()
//            center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
//        }
//        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//        UIApplication.shared.registerForRemoteNotifications()
//    }

//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
//        print("APNs device token: \(deviceTokenString)")
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("APNs registration failed: \(error)")
//    }
//}



////6. Create a new file called SampleNotificationDelegate, this will allow the app to call Notification even when it's open
//
//import Foundation
//import UserNotifications
//import UserNotificationsUI
//
//class SampleNotificationDelegate: NSObject , UNUserNotificationCenterDelegate {
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert,.sound])
//    }
//
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        switch response.actionIdentifier {
//        case UNNotificationDismissActionIdentifier:
//            print("Dismiss Action")
//        case UNNotificationDefaultActionIdentifier:
//            print("Open Action")
//        case "Snooze":
//            print("Snooze")
//        case "Delete":
//            print("Delete")
//        default:
//            print("default")
//        }
//        completionHandler()
//    }
//}



//7. Add this to the AppDelegate file

//let notificationDelegate = SampleNotificationDelegate()



////8. Add this to to the function configureNotification() on AppDelegate
//
//center.delegate = notificationDelegate



////9. Update configureNotification(), so now you can send notifications while the app is open

//    center.delegate = notificationDelegate

////10. This part will show

//let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
//let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
//center.setNotificationCategories(Set([deafultCategory]))
//} else {
//    UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//}


////11. This is how your configureNotification() should look like
//func configureNotification() {
//    if #available(iOS 10.0, *) {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
//        center.delegate = notificationDelegate
//        let openAction = UNNotificationAction(identifier: "OpenNotification", title: NSLocalizedString("Abrir", comment: ""), options: UNNotificationActionOptions.foreground)
//        let deafultCategory = UNNotificationCategory(identifier: "CustomSamplePush", actions: [openAction], intentIdentifiers: [], options: [])
//        center.setNotificationCategories(Set([deafultCategory]))
//    } else {
//        UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//    }
//    UIApplication.shared.registerForRemoteNotifications()
//}



//12. With all the added functionality it's time to update the Pusher json


//{
//    "aps":{
//        "alert":"This is the way",
//        "badge":1,
//        "sound":"default",
//        "category":"CustomSamplePush",
//        "mutable-content":"1"
//    }
//}



//13. After all the setup it's time to fill the schemes we need this extension added to the NotificationServiceExtension to get the picture
//
//@available(iOSApplicationExtension 10.0, *)
//extension UNNotificationAttachment {
//
//    static func saveImageToDisk(fileIdentifier: String, data: NSData, options: [NSObject : AnyObject]?) -> UNNotificationAttachment? {
//        let fileManager = FileManager.default
//        let folderName = ProcessInfo.processInfo.globallyUniqueString
//        let folderURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(folderName, isDirectory: true)
//
//        do {
//            try fileManager.createDirectory(at: folderURL!, withIntermediateDirectories: true, attributes: nil)
//            let fileURL = folderURL?.appendingPathComponent(fileIdentifier)
//            try data.write(to: fileURL!, options: [])
//            let attachment = try UNNotificationAttachment(identifier: fileIdentifier, url: fileURL!, options: options)
//            return attachment
//        } catch let error {
//            print("error \(error)")
//        }
//
//        return nil
//    }
//}



////14. Time to update the NotificationServiceExtension file
//

//        var urlString:String? = nil
//        if let urlImageString = request.content.userInfo["urlImageString"] as? String {
//            urlString = urlImageString
//        }
//
//        if urlString != nil, let fileUrl = URL(string: urlString!) {
//            print("fileUrl: \(fileUrl)")
//
//            guard let imageData = NSData(contentsOf: fileUrl) else {
//                contentHandler(bestAttemptContent)
//                return
//            }
//            guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "image.jpg", data: imageData, options: nil) else {
//                print("error in UNNotificationAttachment.saveImageToDisk()")
//                contentHandler(bestAttemptContent)
//                return
//            }
//
//            bestAttemptContent.attachments = [ attachment ]
//        }
//}



////15. This is how the ServiceExtension should look like

//class NotificationService: UNNotificationServiceExtension {
//
//    var contentHandler: ((UNNotificationContent) -> Void)?
//    var bestAttemptContent: UNMutableNotificationContent?
//
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            var urlString:String? = nil
//            if let urlImageString = request.content.userInfo["urlImageString"] as? String {
//                urlString = urlImageString
//            }
//
//            if urlString != nil, let fileUrl = URL(string: urlString!) {
//                print("fileUrl: \(fileUrl)")
//
//                guard let imageData = NSData(contentsOf: fileUrl) else {
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//                guard let attachment = UNNotificationAttachment.saveImageToDisk(fileIdentifier: "image.jpg", data: imageData, options: nil) else {
//                    print("error in UNNotificationAttachment.saveImageToDisk()")
//                    contentHandler(bestAttemptContent)
//                    return
//                }
//
//                bestAttemptContent.attachments = [ attachment ]
//            }
//
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//    override func serviceExtensionTimeWillExpire() {
//        // Called just before the extension will be terminated by the system.
//        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
//        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
//            contentHandler(bestAttemptContent)
//        }
//    }
//
//}



////16. This changes must be reflected on the Pusher json
//
//{
//    "aps":{
//        "alert":"This is the way",
//        "badge":1,
//        "sound":"default",
//        "category":"CustomSampluPush",
//        "mutable-content":"1"
//    },
//    "urlImageString":"https://www.catster.com/wp-content/uploads/2017/08/A-fluffy-cat-looking-funny-surprised-or-concerned.jpg"
//}
//



////17.
//
//import UIKit
//import UserNotifications
//import UserNotificationsUI
//
//class NotificationViewController: UIViewController, UNNotificationContentExtension {
//
//    @IBOutlet var imageView: UIImageView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    @available(iOSApplicationExtension 10.0, *)
//    func didReceive(_ notification: UNNotification) {
//        let content = notification.request.content
//
//        if let urlImageString = content.userInfo["urlImageString"] as? String {
//            if let url = URL(string: urlImageString) {
//                URLSession.downloadImage(atURL: url) { [weak self] (data, error) in
//                    if let _ = error {
//                        return
//                    }
//                    guard let data = data else {
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        self?.imageView.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
//    }
//
//}
//
//extension URLSession {
//
//    class func downloadImage(atURL url: URL, withCompletionHandler completionHandler: @escaping (Data?, NSError?) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
//            completionHandler(data, nil)
//        }
//        dataTask.resume()
//    }
//}



