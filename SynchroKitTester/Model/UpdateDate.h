//
//  UpdateDate.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <SynchroKit/SynchroKit.h>

@interface UpdateDate : NSManagedObject <UpdateDateProtocol>

@property (nonatomic, retain) NSString * objectClassName;
@property (nonatomic, retain) NSString * updateDate;
@property (nonatomic, retain) NSString * dateFormat;

@end
