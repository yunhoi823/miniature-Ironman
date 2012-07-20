//
//  AccountActivity.m
//  Money Keeper
//
//  Created by Tai Won Chung on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccountActivity.h"

@implementation AccountActivity

@synthesize amount = _amount;
@synthesize description = _description;
@synthesize activityType = _activityType;
@synthesize date = _date;

- (id) initWithConstant:(NSInteger)activity withAmount:(double)amount
{
    self = [super init];
    self.activityType = activity;
    self.date = [NSDate date];
    self.description = @"Account is created";
    self.amount = amount;
    return self;
}

@end
