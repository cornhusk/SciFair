//
//  EditProjectViewController.h
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//
#import "ProjectModel.h"
#import <UIKit/UIKit.h>

@interface EditProjectViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate,UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate> {
    UIPickerView *categoryPickerView;
    NSMutableArray *categoryArray;
}
- (IBAction)setProjectPhoto:(id)sender;
- (IBAction)save:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *projectTitleField;
@property (weak, nonatomic) IBOutlet UITextField *schoolField;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UITextView *projectStory1Area;
@property (weak, nonatomic) IBOutlet UITextView *projectStory2Area;
@property (weak,nonatomic) IBOutlet UIImage *projectImage;
@property (weak,nonatomic) IBOutlet UIButton *projectImageButton;
@property (weak,nonatomic) IBOutlet UISegmentedControl *gradeButton;
@property (weak,nonatomic) IBOutlet UIImageView *userImageView;
@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) NSMutableArray *categoryArray;
@property (strong, atomic) ProjectModel *project;





@end
