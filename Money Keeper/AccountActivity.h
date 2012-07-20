//
//  AccountActivity.h
//  Money Keeper
//
//  Created by Tai Won Chung on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AccountActivity : NSObject

@property (nonatomic) double amount;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) NSInteger activityType;

- (id) initWithConstant:(NSInteger)activity withAmount:(double)amount;

@end
