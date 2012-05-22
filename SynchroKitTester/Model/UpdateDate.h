//
//  UpdateDate.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <SynchroKit/SynchroKit.h>

@interface UpdateDate : NSManagedObject <UpdateDateProtocol>

@property (nonatomic, retain) NSString * dateFormat;
@property (nonatomic, retain) NSString * objectClassName;
@property (nonatomic, retain) NSString * updateDate;

@end
