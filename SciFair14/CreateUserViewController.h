//
//  CreateUserViewController.h
//  SciFair14
//
//  Created by Alex V on 1/26/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CreateUserViewController : UIViewController<UITextViewDelegate,UIImagePickerControllerDelegate>{
}

-(IBAction)create:(id)sender;
@property BOOL userCreated;
@property (weak, nonatomic) IBOutlet UIImage *userImage;
@property (weak, nonatomic) IBOutlet UITextField *emailtField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak,nonatomic) IBOutlet UIButton *userImageButton;


@end
