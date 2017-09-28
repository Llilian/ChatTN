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
    [[self LblUser] setText:[self name]];
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

- (IBAction)MsgSend:(id)sender {
    NSString *message = @"Bidle";
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    [[self mCManager] SendMessage:data withPeer:_peerID];
}
@end
