//
//  SynchronousViewController.h
//  SynchroKitTester
//
//  Created by Kamil Burczyk on 19.05.2012.
//  Copyright (c) 2012 Kamil Burczyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <SynchroKit/SynchroKit.h>

@interface SynchronousViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) SKObjectManager *skObjectManager;
@property (retain, nonatomic) NSArray *users;

- (IBAction)download:(id)sender;

- (AppDelegate*) appDelegate;
- (void) startSynchronization;

@end
