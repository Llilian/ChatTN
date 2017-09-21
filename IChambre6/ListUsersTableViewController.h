//
//  ListUsersTableViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ListUsersTableViewController : UITableViewController

- (IBAction)Synchroniser:(id)sender;

@property Room *myRoom2;
@property (strong, nonatomic) IBOutlet UITableView *BtnSync;


@end
