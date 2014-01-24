//
//  ProjectModel.h
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectModel : NSObject

-(void)calculateRating;

@property (strong, atomic) NSString *projectTitle;
@property (strong, atomic) NSString *category;
@property (strong, atomic) NSString *rating;
@property (strong, atomic) NSArray *ratings;
@property (strong, atomic) NSString *school;
@property (strong, atomic) NSString *firstName;
@property (strong, atomic) NSString *lastName;
@property (strong, atomic) NSString *email;
@property (strong, atomic) NSString *story1;
@property (strong, atomic) NSString *story2;
@property (strong,atomic) NSDate *createdAt;
@property (strong,atomic) NSDate *updatedAt;
@property (strong,atomic) NSData *image;

@end
