//
//  Product.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) User *user;

@end
