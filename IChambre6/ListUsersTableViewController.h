//
//  ListUsersTableViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ListUsersTableViewController : UITableViewController <MCNearbyServiceAdvertiserDelegate>

- (IBAction)ResearchUsers:(id)sender;
- (IBAction)Synchronize:(id)sender;

@property Room *myRoom;

@end
