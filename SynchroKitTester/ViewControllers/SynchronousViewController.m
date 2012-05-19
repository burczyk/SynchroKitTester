//
//  SynchronousViewController.m
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 19.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "SynchronousViewController.h"

@interface SynchronousViewController ()

@end

@implementation SynchronousViewController
@synthesize tableView;
@synthesize users;
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
    
    users = [skObjectManager getEntitiesForName:@"User" withPredicate:Nil andSortDescriptor:Nil];
    NSLog(@"USERS: %@", users);    
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [users count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    
    UITableViewCell *cell = (UITableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }    
    
    User *user = [users objectAtIndex:[indexPath row]];
    cell.textLabel.text = user.name;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle]; 
//    cell.detailTextLabel.text = [dateFormatter stringFromDate:[[users objectAtIndex:[indexPath row]] birthDate]];
    cell.detailTextLabel.text = user.name;
    
    return cell;
}

- (IBAction)download:(id)sender {
    users = [skObjectManager getEntitiesForName:@"User" withPredicate:NULL andSortDescriptor:NULL];
    [tableView reloadData];
}

- (AppDelegate*) appDelegate{
    return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}

- (void) startSynchronization {
    SKObjectConfiguration *userConfiguration    = [[SKObjectConfiguration alloc] initWithName:@"User" Class:[User class] downloadPath:@"/get/User"];  
    [skObjectManager addObject:userConfiguration];    
    [skObjectManager run];
}

- (void)dealloc {
    [tableView release];
    [super dealloc];
}
@end
