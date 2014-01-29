//
//  SciFairMasterViewController.m
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "SciFairMasterViewController.h"
#import "SciFairDetailViewController.h"
#import "ProjectModel.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface SciFairMasterViewController () {
    NSMutableArray *_projects;
}
@end

@implementation SciFairMasterViewController


-(IBAction)toggleLogin:(id)sender{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser.isAuthenticated) {
        [PFUser logOut];
        self.loginButton.titleLabel.text=@"Login";

    } else {
        self.loginButton.titleLabel.text=@"Logout";
    }

}


- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);

    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!_projects) {
        _projects = [[NSMutableArray alloc] init];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [self refresh];
}
-(void)refresh{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser.isAuthenticated) {
        self.loginButton.titleLabel.text=@"Logout";
    }
    [self fetchDataFromParse];
}


- (void)fetchDataFromParse
{
    PFQuery *query = [PFQuery queryWithClassName:@"project"];
    [_projects removeAllObjects];
    [self.tableView reloadData];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            // There was an error
            NSLog(@"Error! %@", error);
        
        } else {

            NSLog(@"Successfully retrieved %d projects.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                ProjectModel *project=[[ProjectModel alloc] init];
                project.projectTitle=object[@"projectTitle"];
                project.firstName=object[@"firstName"];
                project.lastName=object[@"lastName"];
                project.email=object[@"email"];
                project.school=object[@"school"];
                project.story1=object[@"story1"];
                project.story2=object[@"story2"];
                project.ratings=object[@"ratings"];
                PFFile *theImage = [object objectForKey:@"projectImage"];
                project.image=[theImage getData];
                
                [_projects insertObject:project atIndex:0];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            }
        }
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ProjectModel *project = _projects[indexPath.row];
    cell.textLabel.text = project.projectTitle;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_projects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ProjectModel *project = _projects[indexPath.row];
        self.detailViewController.selectedProject = project;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ProjectModel *project = _projects[indexPath.row];
        [[segue destinationViewController] setSelectedProject:project];
    }

}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"edit"]){
        PFUser *currentUser = [PFUser currentUser];
        return currentUser.isAuthenticated;
        
    }
    return YES;
    }

@end
