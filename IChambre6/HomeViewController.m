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
#import "MultipeerConnectionManager.h"

@interface HomeViewController ()


@property Room *myRoom;

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _myRoom.UserIdRoom = [[self UserId] text];
    
    ListUsersTableViewController *controller = [segue destinationViewController];
    controller.myRoom = _myRoom;
}


@end
