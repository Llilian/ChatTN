//
//  ListUsersTableViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatViewController.h"
@import MultipeerConnectivity;
#import "Room.h"

@interface ListUsersTableViewController : UITableViewController <MCAdvertiserAssistantDelegate>

- (IBAction)ResearchUsers:(id)sender;
- (IBAction)Synchronize:(id)sender;

-(void) ChangeAdvertiserStatus;
-(void) BrowserConnection;

@property Room *myRoom;
@property MCNearbyServiceAdvertiser *advertiser2;
@property MCSession *mySession;
@property MCBrowserViewController *browserViewController;
@property MCNearbyServiceBrowser *browser;

@end
