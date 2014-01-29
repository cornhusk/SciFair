//
//  LoginViewController.h
//  SciFair14
//
//  Created by Alex V on 1/26/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextViewDelegate>
-(IBAction)login:(id)sender;
-(IBAction)cancel:(id)sender;

@property BOOL loggedIn;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end
