//
//  EditProjectViewController.m
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "EditProjectViewController.h"

@interface EditProjectViewController ()

@end

@implementation EditProjectViewController


@synthesize categoryPicker;
@synthesize categoryArray;




- (IBAction)setProjectPhoto:(id)sender{

    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // Delegate is self
    imagePicker.delegate = self;
    
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];

}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
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

    self.firstNameField.placeholder=@"First";
    self.lastNameField.placeholder=@"Last";
    self.emailtField.placeholder=@"Email";
    self.schoolField.placeholder=@"School";
    self.projectTitleField.placeholder=@"Project Title";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)save{

}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    
    NSLog(@"%@",[categoryArray objectAtIndex:row]);
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
