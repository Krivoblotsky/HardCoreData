//
//  Person.h
//  HardCoreData
//
//  Created by Sergii Kryvoblotskyi on 5/13/15.
//  Copyright (c) 2015 Serg Krivoblotsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
