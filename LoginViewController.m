//
//  LoginViewController.m
//  SciFair14
//
//  Created by Alex V on 1/26/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController


-(IBAction)login:(id)sender{
//login with parse
    [PFUser logInWithUsernameInBackground:self.emailField.text password:self.passwordField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self dismissViewControllerAnimated:YES completion:nil];
                                        } else {
                                            NSString *errorString = [error userInfo][@"error"];
                                            self.errorLabel.text=errorString;
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.emailField.placeholder=@"email";
    self.passwordField.placeholder=@"password";

    
    PFUser *currentUser = [PFUser currentUser];

    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if([identifier isEqualToString:@"new"]){
        return YES;
    }
    NSLog(self.loggedIn ? @"Yes" : @"No");
    return self.loggedIn;
    
}

-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
