//
//  Account.h
//  Money Keeper
//
//  Created by Tai Won Chung on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountActivity.h"
#import "AccountActivityConstants.h"

@interface Account : NSObject

@property (nonatomic) double currentBalance;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *activityHistory;

- (id) initWithBank:(NSString *)bank withName:(NSString *)name withCurrentBalance:(double)balance;
- (void) addAccountActivity:(AccountActivity *)activity;

@end
