//
//  BWTabBarViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWTabBarViewController.h"

#import "BWFirstViewController.h"
#import "BWSecondViewController.h"
#import "BWThirdViewController.h"

#define RGB(r,g,b,a)               [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


@interface BWTabBarViewController ()


@end

@implementation BWTabBarViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    // 修改文字在tabbar上面的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    [self loadAllChildVC];
}

- (void)loadAllChildVC
{
    BWFirstViewController *firstVC = [BWFirstViewController new];
    [self addChildVC:firstVC selectName:@"home_select" unSelectName:@"home_unSelect" title:@"首页"];
    
    BWSecondViewController *secondVC = [BWSecondViewController new];
    [self addChildVC:secondVC selectName:@"message_select" unSelectName:@"message_unSelect" title:@"消息"];
    
    BWThirdViewController *thirdVC = [BWThirdViewController new];
    [self addChildVC:thirdVC selectName:@"user_select" unSelectName:@"user_unSelect" title:@"我的"];
}

- (void)addChildVC:(UIViewController *)vc selectName:(NSString *)selectName unSelectName:(NSString *)unSelectName title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:unSelectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(191, 191, 191, 1)}forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(216, 30, 6, 1),}forState:UIControlStateSelected];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackImage"] forBarMetrics:UIBarMetricsDefault];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    // 改变导航条上面字体的颜色
    [nav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [self addChildViewController:nav];
}












@end
