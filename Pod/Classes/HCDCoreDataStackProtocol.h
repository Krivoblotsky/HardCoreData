//
//  HCDCoreDataStackProtocol.h
//  Pods
//
//  Created by Sergii Kryvoblotskyi on 5/12/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/**
 *  Implement this protocol to create custom CD stacks.
 *  ?
 */
@protocol HCDCoreDataStack <NSObject>

@required

/* Represents current store coordinator */
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/* Represents currentm object model */
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

/* Represents your single source of truth. Associated with main queue. */
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

@end
