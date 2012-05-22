//
//  User.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message;

@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * birthDate;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * isRemoved;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *message;
@property (nonatomic, retain) NSSet *product;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMessageObject:(Message *)value;
- (void)removeMessageObject:(Message *)value;
- (void)addMessage:(NSSet *)values;
- (void)removeMessage:(NSSet *)values;

- (void)addProductObject:(NSManagedObject *)value;
- (void)removeProductObject:(NSManagedObject *)value;
- (void)addProduct:(NSSet *)values;
- (void)removeProduct:(NSSet *)values;

@end
