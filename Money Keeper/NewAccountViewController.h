//
//  NewAccountViewController.h
//  Money Keeper
//
//  Created by Tai Won Chung on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewAccountViewController;

@protocol NewAccountViewControllerDelegate <NSObject>

- (void) cancelNewAccount:(NewAccountViewController *)sender;

@end

@interface NewAccountViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bankName;
@property (weak, nonatomic) IBOutlet UITextField *accountName;
@property (weak, nonatomic) IBOutlet UITextField *currentBalance;
@property (weak, nonatomic) id <NewAccountViewControllerDelegate> delegate;

@end
