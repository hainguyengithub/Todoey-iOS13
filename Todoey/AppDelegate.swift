
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let searchPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    if let last = searchPath.last {
      let result = last as String
      print("AppDelegate: \(result)")
    }
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
  }

  // MARK: UISceneSession Lifecycle

  // func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
  //     // Called when a new scene session is being created.
  //     // Use this method to select a configuration to create the new scene with.
  //   return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  // }
  // 
  // func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  //     // Called when the user discards a scene session.
  //     // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
  //     // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  // }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "DataModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()

    // MARK: - Core Data Saving support

  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }

}
