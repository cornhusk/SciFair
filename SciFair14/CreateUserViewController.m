//
//  CreateUserViewController.m
//  SciFair14
//
//  Created by Alex V on 1/26/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "CreateUserViewController.h"
#import <Parse/Parse.h>

@interface CreateUserViewController ()

@end

@implementation CreateUserViewController


- (IBAction)setUserPhoto:(id)sender{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Delegate is self
    [imagePicker setDelegate:self];
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.userImage=image;
    [self.userImageButton setImage:self.userImage forState:UIControlStateSelected];
    [self.userImageButton setSelected:YES];
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    }




- (IBAction)create:(id)sender{

    
    PFUser *user = [PFUser user];
    user.username = self.emailtField.text;
    user[@"firstName"]=self.firstNameField.text;
    user[@"lastName"]=self.lastNameField.text;
    user.password = self.passwordField.text;
    user.email = self.emailtField.text;

    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [self.userImage drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    user[@"userPic"]=imageFile;

    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSString *errorString = [error userInfo][@"User Created!"];
            self.userCreated=YES;
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            self.errorLabel.text=errorString;
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.userCreated=NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.firstNameField.placeholder=@"first name";
    self.lastNameField.placeholder=@"last name";
    self.emailtField.placeholder=@"your email";
    self.passwordField.placeholder=@"new password";
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
    return self.userCreated;
}



@end
