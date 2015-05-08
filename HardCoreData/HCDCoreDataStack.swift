//
//  HCDCoreDataStack.swift
//  HardCoreDataExample
//
//  Created by Sergii Kryvoblotskyi on 5/8/15.
//  Copyright (c) 2015 Home. All rights reserved.
//

import UIKit
import CoreData

class HCDCoreDataStack: NSObject {
    
    let storeName:String
    let storeType:String
    
    private let libraryFolderURL:NSURL = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.LibraryDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask).last as! NSURL

    convenience init(storeName: String) {
        self.init(storeType:NSSQLiteStoreType, storeName:storeName)
    }
    
    init(storeType: String, storeName: String) {
        self.storeType = storeType
        self.storeName = storeName
    }
    
    //MARK: ---------
    //MARK: Public
    //MARK: ---------
    
    private(set) lazy var managedObjectModel:NSManagedObjectModel? = {
        
        /* Get the url */
        let bundle = NSBundle(forClass: object_getClass(self));
        let modelURL = bundle.URLForResource(self.storeName, withExtension: "momd")
        
        /* Create the model */
        let model = NSManagedObjectModel(contentsOfURL: modelURL!)
        
        return model
    }()
    
    private(set) lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator? = {
       
        let options = [NSMigratePersistentStoresAutomaticallyOption:true, NSInferMappingModelAutomaticallyOption:true]
        let coordinator:NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel!)
        
        let storeName:String = self.storeName + ".sqlite"
        
        var error: NSError? = nil
        let storeURL = self.libraryFolderURL.URLByAppendingPathComponent(storeName)
        if coordinator.addPersistentStoreWithType(self.storeType, configuration: nil, URL: storeURL, options: options, error: &error) == nil {
            //TODO:Handle error here
        }
        return coordinator
    }()
    
    private(set) lazy var mainManagedObjectContext:NSManagedObjectContext? = {
        
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        context.parentContext = self.writerManagedObjectContext
        return context
    }()
    
    private(set) lazy var writerManagedObjectContext:NSManagedObjectContext? = {
       
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
}
