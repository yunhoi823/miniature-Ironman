//
//  NewAccountViewController.m
//  Money Keeper
//
//  Created by Tai Won Chung on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewAccountViewController.h"
#import "AlertTypeConstants.h"

@interface NewAccountViewController ()

@end

@implementation NewAccountViewController

@synthesize bankName;
@synthesize accountName;
@synthesize currentBalance;
@synthesize delegate;
// Taiwon added this comment
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.bankName setDelegate:self];
    [self.accountName setDelegate:self];
    [self.currentBalance setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setBankName:nil];
    [self setAccountName:nil];
    [self setCurrentBalance:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) presentAlertMessage:(NSString *)message withErrorType:(NSInteger)type
{
    if (type == NewAccountAlertTypeError) { 
        // these are allerts that you never want users to progress further in setting up a new account without resolving them
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alert show];
    }
    if (type == NewAccountAlertTypeWarning) {
        // these are allerts that you can let them continue if they want to
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:message delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

#pragma mark target/action

- (IBAction)donePressed:(id)sender 
{
    NSString *bank = bankName.text;
    NSString *account = accountName.text;
    NSString *balance = currentBalance.text;
    if ([bank isEqualToString:@""] || [account isEqualToString:@""]) {
        [self presentAlertMessage:@"You did not enter at least one of the required fields" withErrorType:NewAccountAlertTypeError];
        return;
    }
    if ([balance doubleValue] == 0.0f) {
        [self presentAlertMessage:@"Your entry for for current balance is $0.00. Are you sure you want to continue?" withErrorType:NewAccountAlertTypeWarning];
        return;
    }
    [self.delegate saveNewAccount:self];
}

- (IBAction)cancelPressed:(id)sender
{
    [self.delegate cancelNewAccount:self];
}

#pragma mark UITextFieldDelegate methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.bankName) {
        [textField resignFirstResponder];
        [self.accountName becomeFirstResponder];
    } else if (textField == self.accountName){
        [textField resignFirstResponder];
        [self.currentBalance becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark UIAlertViewDelegate methods

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.delegate saveNewAccount:self];
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
    }
}

@end
