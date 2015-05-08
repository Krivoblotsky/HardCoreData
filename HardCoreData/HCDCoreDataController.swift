//
//  HCDCoreDataController.swift
//  HardCoreDataExample
//
//  Created by Sergii Kryvoblotskyi on 5/8/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

import UIKit
import CoreData

class HCDCoreDataController: NSObject {
   
    let stack:HCDCoreDataStack
    
    var mainMOC:NSManagedObjectContext? {
        get {
            return self.stack.mainManagedObjectContext
        }
    }
    
    var writerMOC:NSManagedObjectContext? {
        get {
            return self.stack.writerManagedObjectContext
        }
    }
    
    var persistentStoreCoordinator:NSPersistentStoreCoordinator? {
        get {
            return self.stack.persistentStoreCoordinator
        }
    }
    
    var managedObjectModel:NSManagedObjectModel? {
        get {
            return self.stack.managedObjectModel
        }
    }
    
    init(stack:HCDCoreDataStack) {
        self.stack = stack
    }
    
    //MAKR:
    //MAKR: Public
    //MAKR:
    
    func createChildContextWithType(type : NSManagedObjectContextConcurrencyType) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: type)
        context.parentContext = self.mainMOC
        return context
    }
    
    func save() {
        
        /* Check changes in both contexts */
        if self.mainMOC?.hasChanges == nil && self.writerMOC?.hasChanges == nil {
            return
        }
        
        /* Save main MOC */
        self.mainMOC?.performBlockAndWait({ () -> Void in
            
            var error: NSError? = nil
            if self.mainMOC?.save(&error) != nil {
                
                /* Save writer MOC */
                self.writerMOC?.performBlock({ () -> Void in
                    
                    var error: NSError? = nil
                    if self.writerMOC?.save(&error) == nil {
                        println("Core Data encountered serious error (/error)")
                    }
                })
            } else {
                println("Core Data encountered serious error (/error)")
            }
        })
    }
}
