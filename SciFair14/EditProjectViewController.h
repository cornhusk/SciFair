//
//  EditProjectViewController.h
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//
#import "ProjectModel.h"
#import <UIKit/UIKit.h>

@interface EditProjectViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate> {
    UIPickerView *categoryPickerView;
    NSMutableArray *categoryArray;
}
- (IBAction)setProjectPhoto:(id)sender;

@property (weak, nonatomic) IBOutlet ProjectModel *project;
@property (weak, nonatomic) IBOutlet UITextField *projectTitleField;
@property (weak, nonatomic) IBOutlet UITextField *schoolField;
@property (weak, nonatomic) IBOutlet UITextField *emailtField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UITextView *projectStory1Area;
@property (weak, nonatomic) IBOutlet UITextView *projectStory2Area;
@property (weak,nonatomic) IBOutlet UIImageView *projectImage;
@property (weak,nonatomic) IBOutlet UIImageView *UserImage;
@property (strong,nonatomic) NSMutableArray *categoryArray;





@end
