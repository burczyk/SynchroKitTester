//
//  Message.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-02-27.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Message : NSManagedObject

@property (nonatomic) int32_t identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSManagedObject *user;

@end
