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

- (void)viewDidLoad {
    [super viewDidLoad];

    [[self LblUser] setText:[@"Discussion avec " stringByAppendingString:_peerIDFriend.displayName]];
    
    // Création des bord pour le label et la textView
    UIColor *borderColor = [[UIColor alloc] initWithRed:0.85 green:0.85 blue:0.85 alpha:1.0];
    _TvMsgEnv.layer.borderWidth = 0.8;
    _TvMsgEnv.layer.borderColor = borderColor.CGColor;
    _TvMsgEnv.layer.cornerRadius = 5.0;

    _TvMsgRecu.layer.borderWidth = 0.5;
    _TvMsgRecu.layer.borderColor = borderColor.CGColor;
    _TvMsgRecu.layer.cornerRadius = 5.0;    
    
    if ([[_myRoom.conversationUsers allKeys] containsObject:_peerIDFriend])
        _TvMsgRecu.text = [_myRoom.conversationUsers objectForKey:_peerIDFriend];

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
        
        _TvMsgRecu.text = [_myRoom.conversationUsers objectForKey:peerID];
    });
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
        
        if ([[_myRoom.conversationUsers allKeys] containsObject:_peerIDFriend])
            _myRoom.conversationUsers[_peerIDFriend] = [[_myRoom.conversationUsers[_peerIDFriend] stringByAppendingString:@"\n\t\t\t\t\t\t\t\t\t"] stringByAppendingString:message];
        else
            _myRoom.conversationUsers[_peerIDFriend] = [@"\t\t\t\t\t\t\t\t\t" stringByAppendingString:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _TvMsgRecu.text = [_myRoom.conversationUsers objectForKey:_peerIDFriend];
        });
        
        _TvMsgEnv.text = @"";
    }
}

@end
