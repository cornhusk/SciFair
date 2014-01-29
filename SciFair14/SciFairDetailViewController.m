//
//  SciFairDetailViewController.m
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "SciFairDetailViewController.h"

@interface SciFairDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation SciFairDetailViewController

#pragma mark - Managing the detail item

- (void)setSelectedProject:(ProjectModel *)newSelectedProject
{
    if (_selectedProject != newSelectedProject) {
        _selectedProject = newSelectedProject;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.selectedProject) {
        self.projectTitleView.title = self.selectedProject.projectTitle;
        self.categoryLabel.text = self.selectedProject.category;
        self.nameLabel.text =self.selectedProject.firstName;
        self.schoolLabel.text =self.selectedProject.school;
        self.ratingLabel.text = [self.selectedProject rating];
        self.projectStory1Area.text = self.selectedProject.story1;
        self.projectStory1Area.editable = NO;
        self.projectStory2Area.text = self.selectedProject.story2;
        self.projectStory2Area.editable = NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.projectImage.image=[UIImage imageWithData:self.selectedProject.image];
    [self configureView];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
