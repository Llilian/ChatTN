//
//  Room.m
//  IChambre6
//
//  Created by Lilian Le Mee on 13/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "Room.h"
@import MultipeerConnectivity;

@implementation Room

- (instancetype)init
{
    self = [super init];
    if (self) {
        _usersAccepted = [NSMutableArray array];
        _usersRejected = [NSMutableArray array];
        _conversationUsers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(bool) acceptedContainsPeer:(MCPeerID *)peerID
{
    for (int i =0; i < [_usersAccepted count]; i++ ){
        if ([ _usersAccepted containsObject:peerID])
            return true;
    }
    return false;
}

-(bool) rejectedContainsPeer:(MCPeerID *)peerID
{
    for (int i =0; i < [_usersRejected count]; i++ ){
        if ([ _usersRejected containsObject:peerID])
            return true;
    }
    return false;
}


-(MCPeerID *) returnPeerIDPeopleToTalk:(NSString *)namePeerID
{
    for (int i =0; i < [_usersAccepted count]; i++ ){
        if ([[[ _usersAccepted objectAtIndex:i] displayName] isEqualToString:namePeerID])
            return [ _usersAccepted objectAtIndex:i];
    }
    return nil;
}

-(void) addUser:(MCPeerID *)peerID andStatus: (bool *) status
{
    if(status){
        [_usersAccepted addObject:peerID];
    }else{
        [_usersRejected addObject:peerID];
    }
}

-(void) changeStatusUser : (MCPeerID *) peerID
{
  if ([ _usersAccepted containsObject:peerID]) {
    [_usersAccepted removeObject:peerID];
    [_usersRejected addObject:peerID];
  }
  else if ([ _usersRejected containsObject:peerID]) {
    [_usersRejected removeObject:peerID];
    [_usersAccepted addObject:peerID];
  }
}

@end
