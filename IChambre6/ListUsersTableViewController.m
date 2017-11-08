//
//  ListUsersTableViewController.m
//  IChambre6
//
//  Created by Lilian Le Mee on 21/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "ListUsersTableViewController.h"

@interface ListUsersTableViewController ()

@property MultipeerConnectionManager *mCManager;

@end

@implementation ListUsersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mCManager = [[MultipeerConnectionManager alloc] init];

    MCNearbyServiceAdvertiser *advertiser = [_mCManager Initialization:_myRoom];
    [advertiser setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ResearchUsers:(id)sender {
    [_mCManager BrowserConnection:[self myRoom]];

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
    return [_myRoom.UsersAccepted count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"item" forIndexPath:indexPath];

    [[cell textLabel] setText:[[[[self myRoom] UsersAccepted] objectAtIndex:indexPath.row] displayName]];

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
    [controller setName: [[sender textLabel] text]];
    [controller setMCManager:[self mCManager]];
    [controller setPeerID:[[_myRoom UsersAccepted] objectAtIndex:0]]; // Passage du peerID
}


#pragma mark - MCNearbyServiceAdvertiserDelegate

-(void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
      withContext:(NSData *)context
invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler
{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
                                                                   message: [[peerID displayName] stringByAppendingString:@" veut discuter avec vous !"]
                                                            preferredStyle:UIAlertControllerStyleAlert];

//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Connexion entrante"
//                                                                   message:@"Quelqu'un veut discuter avec vous !"
//                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Accepté" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                         {
                             [_myRoom addUser:peerID andStatus:(bool *) true];
                             invitationHandler(YES, [_mCManager mySession]);
                         }];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Rejeté" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                             {
                                 [_myRoom addUser:peerID andStatus:(bool *) false];
                                 invitationHandler(NO, nil);
                             }];

    [alert addAction:cancel];
    [alert addAction:ok];

    /*[self dismissViewControllerAnimated:YES completion:^{
        nil;
    }];*/

    [self presentViewController:alert animated:YES completion:nil];

}

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session
    didReceiveData:(NSData *)data
    fromPeer:(MCPeerID *)peerID
{
    // Sauvegarde dans fichier Json conversation ( Pour avoir plusieurs conversation même temps)
    // Si chat avec 1 : moi écrit : affiche dans fenêtre et sauvegarde dans fichier Json
    //  1 écrit : affiche et write json file
    // Je quitte chat avec 1 et chat avec 2 :
    //  Si 1 écrit, n'affiche pas (pas dans son chat) mais enregistre (Me notifie ?).
    // Quand je reviens chat avec lui : charge conversation du Json file

    // Quand je quitte l'application : 2 choix :
    //  * Supprime conversation existante
    //  * Garde conversation existante + affiche aux prochaines connexion (Mais normalement impossible de lié à un PeerID).
}


@end
