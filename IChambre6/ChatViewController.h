//
//  ChatViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 18/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipeerConnectionManager.h"

@interface ChatViewController : UIViewController <MCSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *LblUser;
@property (weak, nonatomic) IBOutlet UITextView *TvMsgEnv;
@property (weak, nonatomic) IBOutlet UILabel *LblMsgRecu;

@property (weak, nonatomic) IBOutlet UIButton *BtnEnv;

@property MultipeerConnectionManager *mCManager;
@property MCPeerID *peerID;


- (IBAction)MsgSend:(id)sender;

@end
