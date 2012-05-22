//
//  AsynchronousViewController.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 22.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <SynchroKit/SynchroKit.h>

@interface AsynchronousViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) SKObjectManager *skObjectManager;
@property (retain, nonatomic) NSArray *messages;

- (IBAction)download:(id)sender;

- (AppDelegate*) appDelegate;
- (void) startSynchronization;

@end
