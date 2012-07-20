//
//  Account.m
//  Money Keeper
//
//  Created by Tai Won Chung on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize currentBalance = _currentBalance;
@synthesize bank = _bank;
@synthesize name = _name;
@synthesize activityHistory = _activityHistory;

- (id) initWithBank:(NSString *)bank withName:(NSString *)name withCurrentBalance:(double)balance
{
    self = [super init];
    self.currentBalance = balance;
    self.name = name;
    self.bank = bank;
    AccountActivity *activity = [[AccountActivity alloc] initWithConstant:AccountActivityAccountCreated withAmount:self.currentBalance];
    [self.activityHistory addObject:activity];
    return self;
}

- (NSMutableArray *) activityHistory
{
    if (!_activityHistory)
        _activityHistory = [[NSMutableArray alloc] init];
    return _activityHistory;
}

- (void) addAccountActivity:(AccountActivity *)activity
{
    [self.activityHistory addObject:activity];
}

@end
