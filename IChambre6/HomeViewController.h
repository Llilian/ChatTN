//
//  HomeViewController.h
//  IChambre6
//
//  Created by Lilian Le Mee on 13/09/2017.
//  Copyright © 2017 Lilian Le Mee. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MultipeerConnectivity;

@interface HomeViewController : UIViewController <MCAdvertiserAssistantDelegate>

- (IBAction)Connexion:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *UserId;
@property MCNearbyServiceAdvertiser *advertiser;
@end
