//
//  FriendsTableViewController.m
//  Pokemon
//
//  Created by Sam Moore on 9/6/14.
//  Copyright (c) 2014 sammoore. All rights reserved.
//

#import "FriendsTableViewController.h"

@interface FriendsTableViewController ()

@property (strong, nonatomic) NSArray *friends;
@property (strong, nonatomic) NSDictionary *currentUser;

@end

@implementation FriendsTableViewController

#pragma mark - lazy instantiation

- (NSArray *)friends {
    if (_friends == nil) {
        [FacebookAPI getUserFriends:self];
    }
        
    return _friends;
}

- (NSDictionary *)currentUser {
    if (_currentUser == nil) {
        [FacebookAPI getPublicProfile:self];
    }
    
    return _currentUser;
}

#pragma mark - FBAPIDelegate

- (void)userFriendsReceived:(NSArray *)usersFriends
{
    _friends = usersFriends;
    [self.tableView reloadData];
}

// user profile
- (void)publicProfileReceived:(NSDictionary *)user
{
    _currentUser = user;
    [self.tableView reloadData];
}


#pragma mark - TableVC overrides

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        //[FacebookAPI getPublicProfile:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.currentUser == nil || self.friends == nil) return 0;
    return [self.friends count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifierForIndexPath:indexPath]];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self cellIdentifierForIndexPath:indexPath]];
    }
    
    NSDictionary *user = nil;
    
    if (indexPath.row == 0) {
        user = self.currentUser;
    } else {
        user = [self.friends objectAtIndex:(indexPath.row - 1)];
    }
    
    cell.textLabel.text = user[@"name"];
    // TODO: add the profile pictures too bruh
    
    return cell;
}

- (NSString *)cellIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return @"User";
    } else {
        return [@"Friend " stringByAppendingString:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
