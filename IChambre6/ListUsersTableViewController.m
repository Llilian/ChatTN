//
//  ListUsersTableViewController.m
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "ListUsersTableViewController.h"
#import "ChatViewController.h"
#import "Room.h"

@interface ListUsersTableViewController ()

@end

@implementation ListUsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_myRoom2.UsersAccepted count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];
    
    [[cell textLabel] setText:[[[[self myRoom2] UsersAccepted] objectAtIndex:indexPath.row] displayName]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ChatViewController *controller = [segue destinationViewController];
    [controller setName: [[sender textLabel] text]];
}


- (IBAction)Synchroniser:(id)sender {
    
    [[self BtnSync] setBackgroundColor:[UIColor redColor]];
    [self.view setNeedsDisplay];
    [[self BtnSync] setBackgroundColor:[UIColor greenColor]];
    /*
    for (int i =0; i < [_myRoom2.UsersAccepted count]; i++ ){
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
        [[cell textLabel] setText:[_myRoom2.UsersAccepted objectAtIndex:i]];
    }*/
}
@end
