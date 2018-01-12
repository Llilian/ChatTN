//
//  ListUsersTableViewController.m
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "ListUsersTableViewController.h"

@interface ListUsersTableViewController ()

@end

//MCNearbyServiceAdvertiser *advertiser;
static NSString * const service = @"ichambre";
MCNearbyServiceAdvertiser *advertiser;

@implementation ListUsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mCManager = [[MultipeerConnectionManager alloc] init];
    
    [_mCManager Initialization:_myRoom];
    
    _mCManager.advertiser.delegate = self;

    [_mCManager.advertiser startAdvertisingPeer];
    
    _mCManager.mySession.delegate = self;
    
    _mCManager.browserViewController.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ResearchUsers:(id)sender {
    
    [self presentViewController: [_mCManager browserViewController]
                       animated:YES completion:^{
                           [[_mCManager browser] startBrowsingForPeers];
                       }];

}

- (IBAction)Synchronize:(id)sender {

    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_myRoom.usersAccepted count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];

    [[cell textLabel] setText:[[[[self myRoom] usersAccepted] objectAtIndex:indexPath.row] displayName]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ChatViewController *controller = [segue destinationViewController];
    [controller setMCManager:_mCManager];
    [controller setMyRoom:_myRoom];
    [controller setPeerIDFriend:[_myRoom returnPeerIDPeopleToTalk:[[sender textLabel] text]]]; // Passage du peerID
}


#pragma mark - MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
       withContext:(NSData *)context
 invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
                                                                   message: [[peerID displayName] stringByAppendingString:@" veut discuter avec vous !"]
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Accepté" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             [_myRoom addUser:peerID andStatus:(bool *) true];
                             invitationHandler(YES, [_mCManager mySession]);
                             [[self tableView] reloadData];
                         }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Rejeté" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                             {
                                 [_myRoom addUser:peerID andStatus:(bool *) false];
                                 invitationHandler(NO, nil);
                             }];

    [alert addAction:cancel];
    [alert addAction:ok];

    [self dismissViewControllerAnimated:YES completion:^{nil;}];
    
    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - MCNearbyServiceBrowserDelegate

- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:^{nil;}];
    [[self tableView] reloadData];
}


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [self dismissViewControllerAnimated:YES completion:^{nil;}];
}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session
    didReceiveData:(NSData *)data
    fromPeer:(MCPeerID *)peerID
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
                                                                   message: [message stringByAppendingString:@" : message"]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:peerID.displayName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             nil;
                         }];

    [alert addAction:ok];
    
    [self dismissViewControllerAnimated:YES completion:^{nil;}];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)session:(nonnull MCSession *)session didFinishReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID atURL:(nullable NSURL *)localURL withError:(nullable NSError *)error {
    
}


- (void)session:(nonnull MCSession *)session didReceiveStream:(nonnull NSInputStream *)stream withName:(nonnull NSString *)streamName fromPeer:(nonnull MCPeerID *)peerID {
    
}


- (void)session:(nonnull MCSession *)session didStartReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID withProgress:(nonnull NSProgress *)progress {
    
}


- (void)session:(nonnull MCSession *)session peer:(nonnull MCPeerID *)peerID didChangeState:(MCSessionState)state {
    if(state == 2 && ![_myRoom acceptedContainsPeer:peerID])
        [_myRoom addUser:peerID andStatus:(bool *) true];
}


@end
