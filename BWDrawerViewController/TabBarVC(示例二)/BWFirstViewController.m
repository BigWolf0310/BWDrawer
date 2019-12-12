//
//  BWFirstViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWFirstViewController.h"


@interface BWFirstViewController ()

@end

@implementation BWFirstViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.drawVC.slideEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadLeftRightButton];
}


- (void)loadLeftRightButton
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"左开" forState:UIControlStateNormal];
    [leftButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"右开" forState:UIControlStateNormal];
    [rightButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}


#pragma mark - leftButton
- (void)leftButton:(UIButton *)button
{
    [self.drawVC showLeftVCAnimated:YES];
}

#pragma mark - rightButton
- (void)rightButton:(UIButton *)button
{
    [self.drawVC showRightVCAnimated:YES];
}







@end
