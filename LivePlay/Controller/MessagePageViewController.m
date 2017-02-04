//
//  MessagePageViewController.m
//  LivePlay
//
//  Created by 123456 on 16/12/7.
//  Copyright © 2016年 123456. All rights reserved.
//

#import "MessagePageViewController.h"
#import "RDVTabBarItem.h"
#import "RDVTabBarController.h"

@interface MessagePageViewController ()

@end

@implementation MessagePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self rdv_tabBarItem] setBadgeValue:@"3"];
    self.rdv_tabBarItem.badgePositionAdjustment = UIOffsetMake(-20, 5);
    self.rdv_tabBarItem.badgeTextFont = [UIFont systemFontOfSize:5];
    self.rdv_tabBarItem.badgeBackgroundColor = RGBColor(244, 48, 50);
    self.rdv_tabBarItem.badgeTextColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
