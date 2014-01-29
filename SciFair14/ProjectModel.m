//
//  ProjectModel.m
//  SciFair14
//
//  Created by Alex V on 1/24/14.
//  Copyright (c) 2014 Alex V. All rights reserved.
//

#import "ProjectModel.h"

@implementation ProjectModel

-(NSString*)rating{
    NSInteger total=0;
    for (NSUInteger i = 0; i < self.ratings.count; i++)
    {
        NSNumber *rating=self.ratings[i];
        total+=[rating intValue];
        NSLog(@"%@",rating);
        
    }
    NSInteger average = total/self.ratings.count;
    return [NSString stringWithFormat:@"%li", (long)average];

}
- (id) init
{
    if (self = [super init])
    {
        self.ratings=[[NSArray alloc]init];
    }
    return self;
}


@end
