//
//  HCDCoreDataStackController.h
//  Pods
//
//  Created by Sergii Kryvoblotskyi on 5/12/15.
//
//

#import <Foundation/Foundation.h>
#import "HCDCoreDataStack.h"

@interface HCDCoreDataStackController : NSObject

/**
 *  Convenience initializer
 *
 *  @param stack HCDCoreDataStack
 *
 *  @return HCDCoreDataStackController
 */
+ (instancetype)controllerWithStack:(id <HCDCoreDataStack>)stack;

/**
 *  Designated initializer
 *
 *  @param stack HCDCoreDataStack
 *
 *  @return HCDCoreDataStackController
 */
- (instancetype)initWithStack:(id <HCDCoreDataStack>)stack NS_DESIGNATED_INITIALIZER;

/* Represents current stack */
@property (nonatomic, strong, readonly) HCDCoreDataStack *stack;

/**
 * Instantiates new child context with given concurrency type.
 * You are responsive for retaining.
 */
- (NSManagedObjectContext *)createChildContextWithType:(NSManagedObjectContextConcurrencyType)type;

/**
 *  Saves the main context and pushes changes to the store.
 *  Its thread-safe to call it.
 */
- (void)save;

@end

@interface HCDCoreDataStackController (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end