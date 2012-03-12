//
//  AppDelegate.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-02-25.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "User.h"
#import "Message.h"
#import "UpdateDate.h"
#import <SynchroKit/SynchroKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    RKObjectManager *rkObjectManager;
    SKObjectManager *skObjectManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) RKObjectManager* rkObjectManager;
@property (nonatomic, retain) SKObjectManager *skObjectManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void) initializeRestKit;
- (void) setMapping;

- (void) startSynchronization;

@end
