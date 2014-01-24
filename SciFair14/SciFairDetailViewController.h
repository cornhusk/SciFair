//
//  SciFairDetailViewController.h
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectModel.h"
@interface SciFairDetailViewController : UIViewController <UISplitViewControllerDelegate>



@property (strong, nonatomic) ProjectModel *selectedProject;

@property (weak, nonatomic) IBOutlet UINavigationItem *projectTitleView;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *projectStory1Area;
@property (weak, nonatomic) IBOutlet UITextView *projectStory2Area;
@property (weak,nonatomic) IBOutlet UIImageView *projectImage;

@end
