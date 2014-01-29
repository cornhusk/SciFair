//
//  EditProjectViewController.m
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "EditProjectViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
@interface EditProjectViewController ()

@end

@implementation EditProjectViewController


@synthesize categoryPicker;
@synthesize categoryArray;




- (IBAction)setProjectPhoto:(id)sender{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Delegate is self
    [imagePicker setDelegate:self];
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [textView resignFirstResponder];
    return YES;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    self.projectImage=image;
    [self.projectImageButton setImage:self.projectImage forState:UIControlStateSelected];
    [self.projectImageButton setSelected:YES];
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
    self.project.image=imageData;
}

-(void)viewDidLayoutSubviews{
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser.isAuthenticated) {
        NSLog(@":%@",currentUser);
        
        NSLog(currentUser.isAuthenticated?@"Logged in":@"not logged in");
    } else {
        NSLog(@"Show Login Screen");
        LoginViewController *login=[[LoginViewController alloc]init];
        [self presentModalViewController:login animated:YES];
        return;
    }
    
    
    
	// Do any additional setup after loading the view.
    categoryArray = [[NSMutableArray alloc] init];
    
    // Add some data for demo purposes.
    [categoryArray addObject:@"Animal Science"];
    [categoryArray addObject:@"Chemistry"];
    [categoryArray addObject:@"Consumer Products Testing"];
    [categoryArray addObject:@"Energy"];
    [categoryArray addObject:@"Engineering"];
    [categoryArray addObject:@"Math/Computer Science"];
    [categoryArray addObject:@"Microbiology"];
    [categoryArray addObject:@"Physics"];
    [categoryArray addObject:@"Behavioral & Social Science"];
    [categoryArray addObject:@"Earth Science"];
    [categoryArray addObject:@"Engineering/Mechanical & Materials"];
    [categoryArray addObject:@"Environmental Science"];
    [categoryArray addObject:@"Medicine & Health"];
    [categoryArray addObject:@"Physics Electromagnetic"];
    [categoryArray addObject:@"Plant Science"];
    [categoryPicker reloadAllComponents];

    NSString *name=[currentUser objectForKey:@"firstName"];
    name=[name stringByAppendingString:[currentUser objectForKey:@"lastName"]];
    PFFile *imagefile=[currentUser objectForKey:@"userPic"];
    NSData *imageData=[imagefile getData];
    self.userImageView.image=[UIImage imageWithData:imageData];

    
    self.nameLabel.text=name;
    self.emailLabel.text=[currentUser objectForKey:@"email"];
    self.schoolField.placeholder=@"School";
    self.projectTitleField.placeholder=@"Project Title";
    
    [self.scrollView sizeToFit];
    self.scrollView.scrollEnabled=YES;
    self.scrollView.contentSize=CGSizeMake([self view].frame.size.width, 900);
    self.project = [[ProjectModel alloc] init];
    self.project.category = [categoryArray objectAtIndex:5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(id)sender{

    self.project.story1= self.projectStory1Area.text;
    self.project.story2= self.projectStory2Area.text;
    self.project.projectTitle= self.projectTitleField.text;
    self.project.ratings = [[NSArray alloc] init];
    
    self.project.grade=[self.gradeButton titleForSegmentAtIndex:self.gradeButton.selectedSegmentIndex];
    
    self.project.school=self.schoolField.text;
    

        NSData *imageData=UIImageJPEGRepresentation(self.projectImage, .05f);
    
    
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    
        NSLog(@"project %@",self.project);
        // Save PFFile
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {

                PFObject *project = [PFObject objectWithClassName:@"project"];
                [project setObject:imageFile forKey:@"projectImage"];
                [project setObject:self.project.school forKey:@"school"];
                [project setObject:self.project.grade forKey:@"grade"];
                [project setObject:self.project.category forKey:@"category"];
                [project setObject:self.project.story1 forKey:@"story1"];
                [project setObject:self.project.story2 forKey:@"story2"];
                [project setObject:self.project.ratings forKey:@"ratings"];
                [project setObject:self.project.projectTitle forKey:@"projectTitle"];
                
                // Set the access control list to current user for security purposes
                project.ACL = [PFACL ACLWithUser:[PFUser currentUser]];
                
                PFUser *user = [PFUser currentUser];
                [project setObject:user forKey:@"user"];
                [project.ACL setPublicReadAccess:YES];
                
                [project saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!error) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else{
                        // Log details of the failure
                        NSLog(@"Error: %@ %@", error, [error userInfo]);
                    }
                }];
            }
            else{
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        } progressBlock:^(int percentDone) {

        }];

    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    self.project.category = [NSString stringWithFormat:@"%@",[categoryArray objectAtIndex:row]];
}
// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [categoryArray count];
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [categoryArray objectAtIndex: row];
    
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    return sectionWidth;
}





@end
