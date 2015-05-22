//
//  HCDExampleDataSource.h
//  HardCoreData
//
//  Created by Sergii Kryvoblotskyi on 5/22/15.
//  Copyright (c) 2015 Serg Krivoblotsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HardCoreData/HCDCoreDataStackController.h>

@interface HCDExampleDataSource : NSObject <UITableViewDataSource>

/**
 *  Convenience initialuzer
 *
 *  @param tableView UITableView
 *  @param coreDataController HCDCoreDataStackController
 *
 *  @return HCDExampleDataSource
 */
+ (instancetype)dataSourceWithTableView:(UITableView *)tableView CoreDataController:(HCDCoreDataStackController *)coreDataController;

/**
 *  Designated initializer
 *
 *  @param tableView UITableView
 *  @param coreDataController HCDCoreDataStackController
 *
 *  @return HCDExampleDataSource
 */
- (instancetype)initWithTableView:(UITableView *)tableView coreDataController:(HCDCoreDataStackController *)coreDataController NS_DESIGNATED_INITIALIZER;

/* Represents current core data controller */
@property (nonatomic, strong, readonly) HCDCoreDataStackController *coreDataController;

/* Reprsents current tableview */
@property (nonatomic, weak, readonly) UITableView *tableView;

/* Performs data fetching */
- (void)performFetch;

@end

@interface HCDExampleDataSource (Unavailable)

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
