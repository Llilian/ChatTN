//
//  HomeViewController.m
//  IChambre6
//
//  Created by Lilian Le Mee on 13/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "HomeViewController.h"
#import "ListUsersTableViewController.h"
#import "Room.h"

@interface HomeViewController ()


@property Room *myRoom;
@property MCSession *mySession2;

@end

MCPeerID *myPeerID2;
BOOL advertiserIsStarted2 = NO;
static NSString * const service2 = @"ichambre";

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _myRoom = [[Room alloc] init];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)Connexion:(id)sender{
    
    _myRoom.UserIdRoom = [[self UserId] text];
  
    myPeerID2 = [[MCPeerID alloc] initWithDisplayName: _myRoom.UserIdRoom];
    
    [self setAdvertiser: [[MCNearbyServiceAdvertiser alloc] initWithPeer:myPeerID2 discoveryInfo:nil serviceType:service2]];
    
    // Par défaut, advertiser est lancé
    
    
    _mySession2 = [[MCSession alloc] initWithPeer:myPeerID2 securityIdentity:nil encryptionPreference:MCEncryptionNone];
    
    NSLog(@"before Invitation");
    
    _advertiser.delegate = self;
    
    [[self advertiser] startAdvertisingPeer];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _myRoom.UserIdRoom = [[self UserId] text];
    
    ListUsersTableViewController *controller = [segue destinationViewController];
    controller.myRoom = _myRoom;
}


#pragma mark - MCNearbyServiceAdvertiserDelegate

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
      withContext:(NSData *)context
invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler
{
    
    NSLog(@"Invitation");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
                                                                   message:@"Quelqu'un veut discuter avec vous !"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Accepté" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             [_myRoom addUser:peerID andStatus:(bool *) true];
                             NSLog(@"Dans OK");
                             [_myRoom containsPeer:(MCPeerID *) @"Nickname"];
                             
                             
                             invitationHandler(YES, _mySession2);
                         }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Rejeté" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                             {
                                 [_myRoom addUser:peerID andStatus:(bool *) false];
                                 NSLog(@"Dans cancel");
                                 [_myRoom containsPeer:(MCPeerID *) @"Nickname"];
                                 
                                 
                                 invitationHandler(NO, nil);
                             }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
    [self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
