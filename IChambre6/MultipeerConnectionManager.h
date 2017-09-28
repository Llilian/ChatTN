//
//  MultipeerConnectionManager.h
//  IChambre6
//
//  Created by Lilian Le Mee on 22/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <MultipeerConnectivity/MultipeerConnectivity.h>
#import "Room.h"

@interface MultipeerConnectionManager : NSObject

@property MCNearbyServiceAdvertiser *advertiser;
@property MCSession *mySession;
@property MCBrowserViewController *browserViewController;
@property MCNearbyServiceBrowser *browser;

-(MCNearbyServiceAdvertiser *) Initialization: (Room *) myRoom;

-(void) ChangeAdvertiserStatus;

-(void) BrowserConnection: (Room *) myRoom;

@end
