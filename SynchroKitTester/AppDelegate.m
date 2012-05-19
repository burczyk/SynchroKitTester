//
//  AppDelegate.m
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 12-02-25.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "AppDelegate.h"

NSString *WEB_ADDRESS = @"http://localhost:8000/";
NSString *PERSISTENT_STORE_NAME = @"SynchroKitTester.sqlite";

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

@synthesize rkObjectManager;
@synthesize skObjectManager;

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    [self initializeRestKit];
    [self setMapping];

    skObjectManager = [[SKObjectManager alloc] initWithNSManagedObjectContext: (NSManagedObjectContext*) self.managedObjectContext RKObjectManager: (RKObjectManager*) rkObjectManager synchronizationStrategy: SynchronizationStrategyDeamon synchronizationInterval: 5];
    
//    [self startSynchronization];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SynchroKitTester" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:PERSISTENT_STORE_NAME];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark RestKit configuration

- (void) initializeRestKit {
    NSLog(@"WEB_ADDRESS: %@", WEB_ADDRESS);
    rkObjectManager = [RKObjectManager objectManagerWithBaseURL:WEB_ADDRESS];
    rkObjectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    rkObjectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:PERSISTENT_STORE_NAME usingSeedDatabaseName:NULL managedObjectModel:[self managedObjectModel] delegate:self];  
}

- (void) setMapping {
    RKManagedObjectMapping *userMapping = [RKManagedObjectMapping mappingForClass:[User class]];
    [userMapping mapKeyPathsToAttributes:@"id", @"identifier", @"name", @"name", nil];
    userMapping.primaryKeyAttribute = @"identifier";
    [rkObjectManager.mappingProvider setMapping:userMapping forKeyPath:@"User"];
    NSLog(@"userMapping done");
    
    RKManagedObjectMapping *messageMapping = [RKManagedObjectMapping mappingForClass:[Message class]];
    [messageMapping mapKeyPathsToAttributes:@"id", @"identifier", @"text", @"text", nil];
    messageMapping.primaryKeyAttribute = @"identifier";
    [rkObjectManager.mappingProvider setMapping:messageMapping forKeyPath:@"Message"];
    NSLog(@"messageMapping done");    
    
    RKManagedObjectMapping *updateDateMapping = [RKManagedObjectMapping mappingForClass:[UpdateDate class]];
    [updateDateMapping mapKeyPathsToAttributes:@"className", @"objectClassName", @"updateDate", @"updateDate", @"dateFormat", @"dateFormat", nil];
    updateDateMapping.primaryKeyAttribute = @"className";
    [rkObjectManager.mappingProvider setMapping:updateDateMapping forKeyPath:@"UpdateDate"];
    NSLog(@"updateDateMapping done");      
    
    RKObjectMapping *userSerializationMapping = [RKObjectMapping mappingForClass:[User class]];    
    [userSerializationMapping mapKeyPathsToAttributes:@"identifier", @"id", @"name", @"name", nil];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:userSerializationMapping forClass:[User class]];  
    
    [[RKObjectManager sharedManager].router routeClass:[User class] toResourcePath:@"/User/add/" forMethod:RKRequestMethodPOST]; 
}

#pragma mark SynchroKit configuration

- (void) startSynchronization {
//    SKObjectConfiguration *userConfiguration    = [[SKObjectConfiguration alloc] initWithName:@"User" Class:[User class] downloadPath:@"/get/User" updateDatePath:@"/get/updateDate/User" updateDateClass:[UpdateDate class] updatedSinceDatePath:@"/get/updatedSinceDate/User" delegate:self asynchronous:TRUE isDeletedSelector:@selector(isRemoved)];
    NSMutableArray *conditions = [[NSMutableArray alloc] init];
    SKCondition *cond1 = [[SKCondition alloc] initWithKey:@"id" condOperator:OperatorGT value:[NSNumber numberWithInt:2]];
    [conditions addObject:cond1];
    SKObjectConfiguration *userConfiguration    = [[SKObjectConfiguration alloc] initWithName:@"User" Class:[User class] downloadPath:@"/get/User" updateDatePath:NULL updateDateClass:[UpdateDate class] updatedSinceDatePath:NULL conditionUpdatePath:@"/get/User" updateConditions: conditions delegate:self asynchronous:TRUE isDeletedSelector:@selector(isRemoved)];    
//    SKObjectConfiguration *messageConfiguration = [[SKObjectConfiguration alloc] initWithName:@"Message" Class:[Message class] downloadPath:@"/get/Message" updateDatePath:@"/get/updateDate/Message" updateDateClass:[UpdateDate class]];
    
    [skObjectManager addObject:userConfiguration];
//    [skObjectManager addObject:messageConfiguration];
    
    [skObjectManager run];
    
//    NSMutableArray *objects = [skObjectManager getEntitiesForName:@"User" withPredicate:Nil andSortDescriptor:Nil];
//    NSLog(@"OBJECTS: %@", objects);
    
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [[NSDateComponents alloc] init];
//    [components setDay:1]; 
//    [components setMonth:1]; 
//    [components setYear:2013];
//    NSDate *date = [calendar dateFromComponents:components];
//    [components release];
//    
//    
//    SKSweepConfiguration *sweepConfiguration = [[SKSweepConfiguration alloc] initWithTimeInterval:5 sweepingStrategy:SweepingStrategyDate maxPersistentStoreSize:100 minLastUpdateDate:date];
//    [skObjectManager runSweeperWithConfiguration:sweepConfiguration persistentStoreCoordinator:[self persistentStoreCoordinator]];
    

    User *newUser = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [newUser setName:@"Kamil"];

    [skObjectManager saveObject: newUser forName:@"User"];
    
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"AppDelegate RKObjectLoaderDelegate error");
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    NSLog(@"AppDelegate RKObjectLoaderDelegate didLoadObjects");    
}

@end
