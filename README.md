# HardCoreData [![Build Status](https://travis-ci.org/Krivoblotsky/HardCoreData.svg?branch=master)](https://travis-ci.org/Krivoblotsky/HardCoreData) [![Version](https://img.shields.io/badge/version-0.1.0-cacaca.svg)](https://github.com/Krivoblotsky/HardCoreData) [![Platform](https://img.shields.io/badge/platform-ios-blue.svg)](https://github.com/Krivoblotsky/HardCoreData)

![teaser](/screenshots/teaser_v2.png)

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

#### HCDCoreDataStackController

The controller to instantiate child MOCs and save the while chain to the persistent store.

```objc

/**
 *  Designated initializer
 *
 *  @param stack HCDCoreDataStack
 *
 *  @return HCDCoreDataStackController
 */
- (instancetype)initWithStack:(id <HCDCoreDataStack>)stack NS_DESIGNATED_INITIALIZER;

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

```


### The whole pattern

```objc

/* Create core data stack */
HCDCoreDataStack *stack = [HCDCoreDataStack sqliteStackWithName:@"Model"];
HCDCoreDataStackController *coreDataController = [HCDCoreDataStackController controllerWithStack:stack];

NSManagedObjectContext *backgroundContext = [coreDataController createChildContextWithType:NSPrivateQueueConcurrencyType];
  [backgroundContext performBlock:^{
   
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:backgroundContext];
    person.firstName = @"John";
    person.lastName = @"Doe";
    
    /* Save child context */
    [backgroundContext save:nil];
    
    /* Save data to store */
    [coreDataController save];
}];

```

Checkout [Example](https://github.com/Krivoblotsky/HardCoreData/tree/master/Example) folder for complete example.

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
