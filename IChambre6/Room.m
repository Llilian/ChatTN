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
        _UsersAccepted = [NSMutableArray array];
        _UsersRejected = [NSMutableArray array];
    }
    return self;
}

-(bool) acceptedContainsPeer:(MCPeerID *)peerID
{
    for (int i =0; i < [_UsersAccepted count]; i++ ){
        if ([ _UsersAccepted containsObject:peerID])
            return true;
    }
    return false;
}

-(bool) rejectedContainsPeer:(MCPeerID *)peerID
{
    for (int i =0; i < [_UsersRejected count]; i++ ){
        if ([ _UsersRejected containsObject:peerID])
            return true;
    }
    return false;
}


-(MCPeerID *) returnPeerIDPeopleToTalk:(NSString *)namePeerID
{
    for (int i =0; i < [_UsersAccepted count]; i++ ){
        if ([[[ _UsersAccepted objectAtIndex:i] displayName] isEqualToString:namePeerID])
            return [ _UsersAccepted objectAtIndex:i];
    }
    return nil;
}

-(void) addUser:(MCPeerID *)peerID andStatus: (bool *) status
{
    if(status){
        [_UsersAccepted addObject:peerID];
    }else{
        [_UsersRejected addObject:peerID];
    }
}

-(void) changeStatusUser : (MCPeerID *) peerID
{
  if ([ _UsersAccepted containsObject:peerID]) {
    [_UsersAccepted removeObject:peerID];
    [_UsersRejected addObject:peerID];
  }
  else if ([ _UsersRejected containsObject:peerID]) {
    [_UsersRejected removeObject:peerID];
    [_UsersAccepted addObject:peerID];
  }
}

@end
