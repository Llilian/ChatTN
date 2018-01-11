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

-(void) Initialization: (Room *) myRoom
{
    myPeerID = [[MCPeerID alloc] initWithDisplayName: myRoom.UserIdRoom];
    
    // Par défaut, advertiser est lancé
    _advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:myPeerID discoveryInfo:nil serviceType:service];
    
    advertiserIsStarted = YES;
    
    _mySession = [[MCSession alloc] initWithPeer:myPeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
    
    _browser = [[MCNearbyServiceBrowser alloc] initWithPeer:myPeerID serviceType:service];
    
    _browserViewController = [[MCBrowserViewController alloc] initWithBrowser:_browser session:_mySession];
    // La gestion de reception des demandes est géré dans ListUsersTableViewController
}

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

-(void) SendMessage: (NSData *)data withPeer: (MCPeerID *)peerID
{
    NSError *error = nil;
    [_mySession sendData:data toPeers:peerID withMode:MCSessionSendDataReliable error:&error];
    //    if (![[self mySession] sendData:data toPeers:peerID withMode:MCSessionSendDataReliable error:&error])
    //        return error;
}

@end
