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

-(bool) containsPeer:(MCPeerID *)peerID
{
    /*if ([_UsersAccepted containsObject:(MCPeerID *) peerID]){
        NSLog(@"containsPeer : true : ");
        NSLog(@"peerID : %@",peerID);
        for (int i =0; i < [_UsersAccepted count]; i++ ){
            NSLog(@"User %d : %@", i,[_UsersAccepted objectAtIndex:i]);
        }
        return true;
    }
    else
    {
        NSLog(@"containsPeer : false : ");
        NSLog(@"peerID : %@",peerID);
        for (int i =0; i < [_UsersRejected count]; i++ ){
            NSLog(@"User %d : %@", i,[_UsersRejected objectAtIndex:i]);
        }
        return false;
    }*/
    NSLog(@"ContainsPeer :");
    for (int i =0; i < [_UsersAccepted count]; i++ ){
        NSLog(@"Accepte User %d : %@", i,[_UsersAccepted objectAtIndex:i]);
    }
    for (int i =0; i < [_UsersRejected count]; i++ ){
        NSLog(@"refuse User %d : %@", i,[_UsersRejected objectAtIndex:i]);
    }
    return true;
}

-(void) addUser:(MCPeerID *)peerID andStatus: (bool *) status
{
    if(status){
        [_UsersAccepted addObject:peerID];
    }else{
        [_UsersRejected addObject:peerID];
    }
}

@end
