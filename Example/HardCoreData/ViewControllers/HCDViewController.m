//
//  HCDViewController.m
//  HardCoreData
//
//  Created by Sergii Kryvoblotskyi on 5/12/15.
//  Copyright (c) 2015 Serg Krivoblotsky. All rights reserved.
//

#import "HCDViewController.h"
#import <HardCoreData/HCDCoreDataStackController.h>
#import "Person.h"
#import "HCDExampleDataSource.h"

@interface HCDViewController () <NSFetchedResultsControllerDelegate>

/* CD stack controller */
@property (nonatomic, strong) HCDCoreDataStackController *coreDataController;

/* DataSource */
@property (nonatomic, strong) HCDExampleDataSource *dataSource;

@end

@implementation HCDViewController

#pragma mark - Accessors

- (HCDCoreDataStackController *)coreDataController
{
    if (!_coreDataController) {
        /* Create core data stack */
        HCDCoreDataStack *stack = [HCDCoreDataStack sqliteStackWithName:@"Model"];
        _coreDataController = [HCDCoreDataStackController controllerWithStack:stack];
    }
    return _coreDataController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [HCDExampleDataSource dataSourceWithTableView:self.tableView CoreDataController:self.coreDataController];
    [self.dataSource performFetch];
}

#pragma mark - Actions

- (IBAction)addButtonClicked:(id)sender
{
    NSManagedObjectContext *backgroundContext = [self.coreDataController createChildContextWithType:NSPrivateQueueConcurrencyType];
    [backgroundContext performBlock:^{
       
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Person class]) inManagedObjectContext:backgroundContext];
        person.firstName = [NSString stringWithFormat:@"First Name %d", arc4random()];
        person.lastName = [NSString stringWithFormat:@"Last Name %d", arc4random()];
        
        /* Save child context */
        [backgroundContext save:nil];
        
        /* Save data to store */
        [self.coreDataController save];
    }];
}

@end
