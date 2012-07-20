//
//  MasterViewController.m
//  Money Keeper
//
//  Created by Tai Won Chung on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_accountList;
}
@end

@implementation MasterViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

#define MONEYKEEPER_DEFAULTS @"UserAccounts"

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newAccount:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _accountList = [defaults objectForKey:MONEYKEEPER_DEFAULTS];
    if (!_accountList) {
        _accountList = [[NSMutableArray alloc] init];
        [defaults setObject:_accountList forKey:MONEYKEEPER_DEFAULTS];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)newAccount:(id)sender
{
    [self performSegueWithIdentifier:@"NewAccountSegue" sender:self];
    /*
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];*/
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _accountList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountCell"];

    cell.textLabel.text = [[_accountList objectAtIndex:indexPath.row] name];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_accountList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [defaults setObject:_accountList forKey:MONEYKEEPER_DEFAULTS];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewAccountSegue"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark NewAccountControllerDelegate

- (void) cancelNewAccount:(NewAccountViewController *)sender
{
    [sender dismissViewControllerAnimated:YES completion:NULL];
}

- (void) saveNewAccount:(NewAccountViewController *)sender atBank:(NSString *)bank withAccountName:(NSString *)name withBalance:(double)balance
{
    [sender dismissViewControllerAnimated:YES completion:NULL];
    Account *newAccount = [[Account alloc] initWithBank:bank withName:name withCurrentBalance:balance];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [_accountList addObject:newAccount];
    [defaults setObject:_accountList forKey:MONEYKEEPER_DEFAULTS];
    [self.tableView reloadData];
    [self.tableView setNeedsDisplay];
}



@end
