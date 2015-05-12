//
//  HCDCoreDataStackTests.m
//  HardCoreData
//
//  Created by Sergii Kryvoblotskyi on 5/12/15.
//  Copyright (c) 2015 Serg Krivoblotsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "expecta.h"
#import "OCMock.h"
#import "HCDCoreDataStack.h"

@interface HCDCoreDataStackTests : XCTestCase

@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, strong) HCDCoreDataStack *stack;

@end

@implementation HCDCoreDataStackTests

- (void)setUp
{
    [super setUp];
    
    _modelName = @"Model";
    _stack = [HCDCoreDataStack stackWithModelName:_modelName storeType:NSInMemoryStoreType];
}

- (void)tearDown
{
    _modelName = nil;
    _stack = nil;
    [super tearDown];
}

#pragma mark - Common

- (void)testFactoryInstancesCreated
{
    HCDCoreDataStack *stack = [HCDCoreDataStack inMemoryStackWithName:self.modelName];
    expect(stack).toNot.beNil();
    
    stack = [HCDCoreDataStack binaryStackWithName:self.modelName];
    expect(stack).toNot.beNil();
    
    stack = [HCDCoreDataStack sqliteStackWithName:self.modelName];
    expect(stack).toNot.beNil();
}

- (void)testModelNameAndStoryTypeSet
{
    NSString *fooName = @"foo_name";
    NSString *fooType = @"foo_type";
    HCDCoreDataStack *stack = [HCDCoreDataStack stackWithModelName:fooName storeType:fooType];
    expect(stack.modelName).to.equal(fooName);
    expect(stack.storeType).to.equal(fooType);
}

#pragma mark - Persistent Store Type

- (void)testPersistentStoreCoordinatorCreatedWithCorrectStore
{
    NSString *type = NSInMemoryStoreType;
    HCDCoreDataStack *stack = [HCDCoreDataStack stackWithModelName:self.modelName storeType:type];
    expect(stack.persistentStoreCoordinator).toNot.beNil();
    expect(stack.persistentStoreCoordinator.persistentStores).haveACountOf(1);
    
    NSPersistentStore *store = stack.persistentStoreCoordinator.persistentStores[0];
    expect(store.type).to.equal(type);
}

#pragma mark - Managed Object Model

- (void)testManagedObjectModelCreated
{
    expect(_stack.managedObjectModel).toNot.beNil();
    expect(_stack.managedObjectModel.entitiesByName[@"Person"]).toNot.beNil();
}

#pragma mark - Contexts

- (void)testMainManagedObjectContextCreated
{
    expect(_stack.mainManagedObjectContext).toNot.beNil();
    expect(_stack.mainManagedObjectContext.concurrencyType).to.equal(NSMainQueueConcurrencyType);
    expect(_stack.mainManagedObjectContext.persistentStoreCoordinator).toNot.beNil();
}

@end
