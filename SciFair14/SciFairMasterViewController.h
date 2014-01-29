//
//  SciFairMasterViewController.h
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SciFairDetailViewController;

@interface SciFairMasterViewController : UITableViewController

-(IBAction)toggleLogin:(id)sender;
-(void)refresh;

@property (weak,nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) SciFairDetailViewController *detailViewController;

@end
