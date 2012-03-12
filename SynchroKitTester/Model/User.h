//
//  User.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-02-27.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface User : NSManagedObject

@property (nonatomic) int32_t identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) NSTimeInterval birthDate;
@property (nonatomic, retain) NSSet *message;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessageObject:(Message *)value;
- (void)removeMessageObject:(Message *)value;
- (void)addMessage:(NSSet *)values;
- (void)removeMessage:(NSSet *)values;
@end
