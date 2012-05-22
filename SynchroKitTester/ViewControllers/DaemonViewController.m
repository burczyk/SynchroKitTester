//
//  DaemonViewController.m
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import "DaemonViewController.h"

@interface DaemonViewController ()

@end

@implementation DaemonViewController

@synthesize tableView;
@synthesize updateLabel;
@synthesize products;
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

    skObjectManager = [[SKObjectManager alloc] initWithNSManagedObjectContext:[[self appDelegate] managedObjectContext] RKObjectManager:[[self appDelegate] rkObjectManager] synchronizationStrategy:SynchronizationStrategyDeamon synchronizationInterval: 5];
    
    [self startSynchronization];
    
    products = [skObjectManager getEntitiesForName:@"Product" withPredicate:Nil andSortDescriptor:Nil];
    NSLog(@"Products: %@", products);
}

- (void)viewDidUnload
{
    [self setUpdateLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableViewDataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TableViewCell";
    
    UITableViewCell *cell = (UITableViewCell*) [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }    
    
    Product *product = [products objectAtIndex:[indexPath row]];
    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = product.desc;
    
    return cell;
}

- (IBAction)download:(id)sender {
    products = [skObjectManager.dataLoader getEntitiesForName:@"Product" withPredicate:Nil andSortDescriptor:Nil];
    [tableView reloadData];
}

- (AppDelegate*) appDelegate{
    return (AppDelegate*) [[UIApplication sharedApplication] delegate];
}

- (void) startSynchronization { 
    SKObjectConfiguration *productConfiguration = [[SKObjectConfiguration alloc] initWithName:@"Product" Class:[Product class] downloadPath:@"/get/Product/" updateDatePath:Nil updateDateClass:Nil updatedSinceDatePath:Nil conditionUpdatePath:Nil updateConditions:Nil delegate:self asynchronous:YES isDeletedSelector:Nil];
    [skObjectManager addObject:productConfiguration];
    [skObjectManager run];
}

#pragma mark RKObjectLoaderDelegate methods

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error {
    NSLog(@"AppDelegate RKObjectLoaderDelegate error");
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    NSLog(@"DaemonViewController RKObjectLoaderDelegate didLoadObjects: %@", objects);   
    NSLog(@"PRODUCT: %@", products);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    updateLabel.text = [NSString stringWithFormat:@"%@, (%d)", [formatter stringFromDate:[NSDate new]], [objects count]];
    [formatter release];   
}

- (void)dealloc {
    [updateLabel release];
    [super dealloc];
}
@end
