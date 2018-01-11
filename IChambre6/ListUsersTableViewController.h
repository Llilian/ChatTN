//
//  ListUsersTableViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewController.h"
#import "MultipeerConnectionManager.h"
#import "Room.h"

@interface ListUsersTableViewController : UITableViewController <MCNearbyServiceAdvertiserDelegate,MCSessionDelegate,MCBrowserViewControllerDelegate>

- (IBAction)ResearchUsers:(id)sender;
- (IBAction)Synchronize:(id)sender;

@property Room *myRoom;
@property MultipeerConnectionManager *mCManager;

@end
