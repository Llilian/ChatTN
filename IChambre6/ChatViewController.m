//
//  ChatViewController.m
//  IChambre6
//
//  Created by Lilian Le Mee on 18/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController
// - Liste dynamique des utilisateurs acepté
// - Mise à jour réguliere
//Bar avec bouton ajouter (fenetre browser) et ..


- (void)viewDidLoad {
    [super viewDidLoad];

    [[self LblUser] setText:[@"Discussion avec " stringByAppendingString:_peerIDFriend.displayName]];

    // Création des bord pour le label et la textView
    UIColor *borderColor = [[UIColor alloc] initWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    _TvMsgEnv.layer.borderWidth = 0.8;
    _TvMsgEnv.layer.borderColor = borderColor.CGColor;
    _TvMsgEnv.layer.cornerRadius = 5.0;

    _LblMsgRecu.layer.borderWidth = 0.5;
    _LblMsgRecu.layer.borderColor = borderColor.CGColor;
    _LblMsgRecu.layer.cornerRadius = 5.0;
    [_LblMsgRecu setNumberOfLines:0];
    //_LblMsgRecu.frame = CGRectMake(68,204,561,554);
    [_LblMsgRecu setTextAlignment:0];
    
    if ([[_myRoom.conversationUsers allKeys] containsObject:_peerIDFriend])
        _LblMsgRecu.text = [_myRoom.conversationUsers objectForKey:_peerIDFriend];

    _mCManager.mySession.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == [self BtnEnv])
        [self setName:[[self TvMsgEnv] text]];
}
*/

#pragma mark - MCSessionDelegate

- (void)session:(MCSession *)session
 didReceiveData:(NSData *)data
       fromPeer:(MCPeerID *)peerID
{
    NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *keys = [_myRoom.conversationUsers allKeys];
        if ([keys containsObject:peerID])
            _myRoom.conversationUsers[peerID] = [[_myRoom.conversationUsers[peerID] stringByAppendingString:@"\n"] stringByAppendingString:message];
        else
              _myRoom.conversationUsers[peerID] = message;
        
        _LblMsgRecu.text = [_myRoom.conversationUsers objectForKey:peerID];
    });

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

- (void)session:(nonnull MCSession *)session didFinishReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID atURL:(nullable NSURL *)localURL withError:(nullable NSError *)error {

}


- (void)session:(nonnull MCSession *)session didReceiveStream:(nonnull NSInputStream *)stream withName:(nonnull NSString *)streamName fromPeer:(nonnull MCPeerID *)peerID {

}


- (void)session:(nonnull MCSession *)session didStartReceivingResourceWithName:(nonnull NSString *)resourceName fromPeer:(nonnull MCPeerID *)peerID withProgress:(nonnull NSProgress *)progress {

}


- (void)session:(nonnull MCSession *)session peer:(nonnull MCPeerID *)peerID didChangeState:(MCSessionState)state {
}

#pragma mark - SendMessage

- (IBAction)MsgSend:(id)sender {
    NSString *message = [_TvMsgEnv text];
    if (![message isEqualToString:@""])
    {
        NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
        [_mCManager SendMessage:data withPeer:_peerIDFriend];
        
        _myRoom.conversationUsers[_peerIDFriend] = [[_myRoom.conversationUsers[_peerIDFriend] stringByAppendingString:@"\n\t\t\t\t\t\t\t\t\t\t\t\t\t"] stringByAppendingString:message];
        dispatch_async(dispatch_get_main_queue(), ^{
            _LblMsgRecu.text = [_myRoom.conversationUsers objectForKey:_peerIDFriend];
        });
        
        _TvMsgEnv.text = @"";
    }
}

@end
