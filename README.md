# HardCoreData

[![Build Status](https://travis-ci.org/Krivoblotsky/HardCoreData.svg?branch=master)](https://travis-ci.org/Krivoblotsky/HardCoreData)

HardCoreData is a yet another core data stack based on Marcus Zarra's multithreading [approach](http://www.cocoanetics.com/2012/07/multi-context-coredata/). This smart approach uncouples the writing into its own private queue and keeps the UI smooth as button.

![teaser](/screenshots/stack_dia.png)

HardCoreData consists of two fundamentals: HCDCoreDataStack and HCDCoreDataStackController.

#### HCDCoreDataStack

Incapsulates native CoreData stack setup.

```objc

/* Convenience initializers */

+ (instancetype)binaryStackWithName:(NSString *)modelName;
+ (instancetype)inMemoryStackWithName:(NSString *)modelName;
+ (instancetype)sqliteStackWithName:(NSString *)modelName;
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
```

#### HCDCoreDataStack protocol

Since HCDCoreDataStack is a protocol as well as a class, you can create your own custom stacks, by implementing <HCDCoreDataStack> protocol.

```objc

@protocol HCDCoreDataStack <NSObject>

@required

/* Represents current store coordinator */
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/* Represents currentm object model */
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

/* Represents your single source of truth. Associated with main queue. */
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainManagedObjectContext;

@end

```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

HardCoreData is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HardCoreData"
```

## Author

Serg Krivoblotsky, krivoblotsky@me.com

## License

HardCoreData is available under the MIT license. See the LICENSE file for more info.
