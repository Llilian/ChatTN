//
//  MultipeerConnectionManager.m
//  IChambre6
//
//  Created by Lilian Le Mee on 22/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "MultipeerConnectionManager.h"

MCPeerID *myPeerID;
BOOL advertiserIsStarted = NO;
static NSString * const service = @"ichambre";

@implementation MultipeerConnectionManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        myPeerID = nil;
    }
    return self;
}

-(MCNearbyServiceAdvertiser *) Initialization: (Room *) myRoom
{
    myPeerID = [[MCPeerID alloc] initWithDisplayName: myRoom.UserIdRoom];
    
    // Par défaut, advertiser est lancé
    [self setAdvertiser: [[MCNearbyServiceAdvertiser alloc] initWithPeer:myPeerID discoveryInfo:nil serviceType:service]];
    
    [[self advertiser] startAdvertisingPeer];
    
    advertiserIsStarted = YES;
    
    // La gestion de reception des demandes est géré dans ListUsersTableViewController
    return [self advertiser]; }

-(void) ChangeAdvertiserStatus
{
    if (!advertiserIsStarted)
    {
        [[self advertiser] startAdvertisingPeer];
        advertiserIsStarted = YES;
    }
    else
    {
        [[self advertiser] stopAdvertisingPeer];
        advertiserIsStarted = NO;
    }
        
}

-(void) BrowserConnection: (Room *) myRoom
{
    _mySession = [[MCSession alloc] initWithPeer:myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];

    _browser = [[MCNearbyServiceBrowser alloc] initWithPeer:myPeerID serviceType:service];
    
    _browserViewController = [[MCBrowserViewController alloc] initWithBrowser:_browser session:_mySession];
}

-(void) SendMessage: (NSData *)data withPeer: (MCPeerID *)peerID
{
    NSError *error = nil;
    [[self mySession] sendData:data toPeers:peerID withMode:MCSessionSendDataReliable error:&error];
//    if (![[self mySession] sendData:data toPeers:peerID withMode:MCSessionSendDataReliable error:&error])
//        return error;
}

@end
