//
//  Room.h
//  IChambre6
//
//  Created by Lilian Le Mee on 13/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MultipeerConnectivity;

@interface Room : NSObject
@property NSString *UserIdRoom;
@property NSMutableArray *UsersAccepted;
@property NSMutableArray *UsersRejected;

-(bool) containsPeer:(MCPeerID *)peerID;
-(void) addUser: (MCPeerID *) peerID andStatus: (bool *) status;
-(void) changeStatusUser : (MCPeerID *) peerID;


@end
