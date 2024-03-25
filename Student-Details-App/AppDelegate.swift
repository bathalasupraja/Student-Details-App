//
//  AppDelegate.swift
//  Student-Details-App
//
//  Created by Supraja on 17/03/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Student_Details_App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate {
    /// Collect all available schools
    func fetchAllSchools(onSuccess: @escaping ([SchoolEntity]?) -> Void) {
        let context = persistentContainer.viewContext
        do {
            let items = try context.fetch(SchoolEntity.fetchRequest()) as? [SchoolEntity]
            onSuccess(items)
        } catch {
            print("error-Fetching data")
        }
    }

    /// Add new school
    func addSchool(name: String, id: Int16, password: String) {
        let context = persistentContainer.viewContext
        let newSchool = SchoolEntity(context: context)
        newSchool.name = name
        newSchool.id = id
        newSchool.password = password
        do {
            try context.save()
        } catch {
            print("error-Saving data")
        }
    }
    
    /// Find school exist or not
    func schoolExists(id: Int16, password: String, onSuccess: @escaping (Bool) -> Void) {
        fetchAllSchools { allSchools in
            if let allSchools, allSchools.first(where: { $0.id == id && $0.password == password }) != nil {
                onSuccess(true)
            } else {
                onSuccess(false)
            }
        }
    }
}
