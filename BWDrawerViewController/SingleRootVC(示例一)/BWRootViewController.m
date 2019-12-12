//
//  BWRootViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWRootViewController.h"


@interface BWRootViewController ()

@end

@implementation BWRootViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 关闭滑动切换抽屉
    self.drawVC.slideEnabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"首页";
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
