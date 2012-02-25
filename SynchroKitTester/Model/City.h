//
//  City.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-02-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic) int32_t identifier;
@property (nonatomic, retain) NSString * name;

@end
