//
//  AsynchronousViewController.m
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "AsynchronousViewController.h"

@interface AsynchronousViewController ()

@end
 
@implementation AsynchronousViewController

@synthesize tableView;
@synthesize messages;
@synthesize skObjectManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    skObjectManager = [[SKObjectManager alloc] initWithNSManagedObjectContext:[[self appDelegate] managedObjectContext] RKObjectManager:[[self appDelegate] rkObjectManager] synchronizationStrategy: SynchronizationStrategyRequest synchronizationInterval: 0];
    
    [self startSynchronization];
    
    messages = [skObjectManager getEntitiesForName:@"Message" withPredicate:Nil andSortDescriptor:Nil];
    NSLog(@"Messages: %@", messages);     
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    
    UITableViewCell *cell = (UITableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }    
    
    Message *message = [messages objectAtIndex:[indexPath row]];
    cell.textLabel.text = message.title;
    cell.detailTextLabel.text = message.text;
    
    return cell;
}

- (IBAction)download:(id)sender {
    messages = [skObjectManager getEntitiesForName:@"Message" withPredicate:NULL andSortDescriptor:NULL];
    [tableView reloadData];
}

- (AppDelegate*) appDelegate{
    return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}

- (void) startSynchronization { 
    SKObjectConfiguration *messageConfiguration = [[SKObjectConfiguration alloc] initWithName:@"Message" Class:[Message class] downloadPath:@"/get/Message/" updateDatePath:@"/get/updateDate/Message" updateDateClass:[UpdateDate class] updatedSinceDatePath:Nil conditionUpdatePath:Nil updateConditions:Nil delegate:self asynchronous:YES isDeletedSelector:Nil];
    [skObjectManager addObject:messageConfiguration];
    [skObjectManager run];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"AppDelegate RKObjectLoaderDelegate error");
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    NSLog(@"AsynchronousViewController RKObjectLoaderDelegate didLoadObjects: %@", objects);   
    messages = [skObjectManager.dataLoader getEntitiesForName:@"Message" withPredicate:Nil andSortDescriptor:Nil];
    NSLog(@"MESSAGES: %@", messages);
    [tableView reloadData];    
}

#pragma mark dealloc

- (void)dealloc {
    [tableView release];
    [super dealloc];
}


@end
