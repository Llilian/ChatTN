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

@property MCNearbyServiceAdvertiser *advertiser;
@property Room *myRoom;
@property MCBrowserViewController *browserViewController;
@property MCSession *session;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myRoom = [[Room alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Connexion:(id)sender{
    
    _myRoom.UserIdRoom = [[self UserId] text];
    NSLog(@"User : %@", _myRoom.UserIdRoom);
    
    static NSString * const Service = @"ichambre";
    MCPeerID *locatePeerID = [[MCPeerID alloc] initWithDisplayName: _myRoom.UserIdRoom];
    
    [self setAdvertiser: [[MCNearbyServiceAdvertiser alloc] initWithPeer:locatePeerID discoveryInfo:nil serviceType:Service]];
    
    [[self advertiser] startAdvertisingPeer];
    _advertiser.delegate = self;
    
    //Creation d'une session
    _session = [[MCSession alloc] initWithPeer:locatePeerID securityIdentity:nil encryptionPreference:MCEncryptionNone];
    
    
    MCNearbyServiceBrowser *browser = [[MCNearbyServiceBrowser alloc] initWithPeer:locatePeerID serviceType:Service];
    //browser.delegate = self;
    
    _browserViewController = [[MCBrowserViewController alloc] initWithBrowser:browser session:_session];
    //browserViewController.delegate = self;
    
    
    [self presentViewController: _browserViewController
                       animated:YES completion:^{
                           [browser startBrowsingForPeers];
                       }];
    //Test : [_myRoom containsPeer:(MCPeerID *) @"Nickname"];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ListUsersTableViewController *controller = [segue destinationViewController];
    controller.myRoom2 = _myRoom;
}


#pragma mark - MCNearbyServiceAdvertiserDelegate

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
      withContext:(NSData *)context
invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler
{
   /* if ([myRoom :peerID]) {
        invitationHandler(NO, nil);
        return;
    }*/
    
    NSLog(@"Invitation");
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
                                                                   message:@"Quelqu'un veut discuter avec vous !"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Accepté" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             [_myRoom addUser:peerID andStatus:(bool *) true];
                             NSLog(@"Dans OK");
                             [_myRoom containsPeer:(MCPeerID *) @"Nickname"];
                             
                             
                             invitationHandler(YES, _session);
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
