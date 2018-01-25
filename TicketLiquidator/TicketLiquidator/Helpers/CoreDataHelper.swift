//
//  CoreDataHelper.swift
//  TicketLiquidator
//
//  Created by Luke Solomon on 1/23/18.
//  Copyright © 2018 Luke Solomon. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper { // Core Data Singleton
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    //static methods will go here
    
//    static func saveUser(WithProfilePicture profilePictureURL:String?, name:String?, coverPhotoURL:String?) {
//        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
//
//        user.profilePictureURL = profilePictureURL
//        user.name = name
//        user.coverPhotoURL = coverPhotoURL
//
//        self.save()
//    }
    
    static func saveEvent() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func save() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(object: SearchEvent) {
        managedContext.delete(object)
        self.save()
    }
    
    static func retrieveEntity(string:String) -> [Any] {
        let fetchRequest = NSFetchRequest<SearchEvent>(entityName: string)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        
        return []
    }
    
}



