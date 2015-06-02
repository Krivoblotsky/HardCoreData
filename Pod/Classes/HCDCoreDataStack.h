//
//  HCDCoreDataStack.h
//  Pods
//
//  Created by Sergii Kryvoblotskyi on 5/12/15.
//
//

#import <Foundation/Foundation.h>
#import "HCDCoreDataStackProtocol.h"

@interface HCDCoreDataStack : NSObject <HCDCoreDataStack>

/**
 *  Convenience initializer that instantiates binary stack with given model name
 *
 *  @param storeName NSString
 *
 *  @return HCDCoreDataStack
 */

+ (instancetype)binaryStackWithName:(NSString *)modelName;

/**
 *  Convenience initializer that instantiates in memory stack with given model name
 *
 *  @param storeName NSString
 *
 *  @return HCDCoreDataStack
 */

+ (instancetype)inMemoryStackWithName:(NSString *)modelName;

#if MAC_OS_X_VERSION_MIN_REQUIRED > MAC_OS_X_VERSION_10_4
/**
 *  Convenience initializer that instantiates xml stack with given model name
 *
 *  @param storeName NSString
 *
 *  @return HCDCoreDataStack
 */

+ (instancetype)XMLStackWithName:(NSString *)modelName;
#endif

/**
 *  Convenience initializer that instantiates sqlite stack with given model name
 *
 *  @param storeName NSString
 *
 *  @return HCDCoreDataStack
 */
+ (instancetype)sqliteStackWithName:(NSString *)modelName;

/**
 *  Convenience. See instance method
 *
 *  @param modelName NSString
 *  @param storeType NSString
 *
 *  @return HCDCoreDataStack
 */
+ (instancetype)stackWithModelName:(NSString *)modelName storeType:(NSString *)storeType;

/**
 *  Designated initializer
 *
 *  @param modelName NSString
 *  @param storeType NSString
 *
 *  @return HCDCoreDataStack
 */

- (instancetype)initWithModelName:(NSString *)modelName storeType:(NSString *)storeType NS_DESIGNATED_INITIALIZER;

/* Represents current model name */
@property (nonatomic, copy, readonly) NSString *modelName;

/* Represents current store type */
@property (nonatomic, copy, readonly) NSString *storeType;

@end

@interface HCDCoreDataStack (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end