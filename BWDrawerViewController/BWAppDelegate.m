//
//  BWAppDelegate.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/10.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWAppDelegate.h"

#import "BWRootViewController.h"

#import "BWLeftViewController.h"
#import "BWRightViewController.h"

#import "BWTabBarViewController.h"

@interface BWAppDelegate ()

@end

@implementation BWAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
 
    // 加载导航控制器/TabBar控制器
    BWDrawViewController *drawVC = [self loadNavigationController:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    [self.window makeKeyAndVisible];
    self.window.rootViewController = drawVC;
    return YES;
}

#pragma mark - 导航控制器/TabBar控制器
- (BWDrawViewController *)loadNavigationController:(BOOL)isTabBar
{
    // 左侧抽屉
    BWLeftViewController *leftVC = [BWLeftViewController new];
    // 右侧抽屉
    BWRightViewController *rightVC = [BWRightViewController new];
    if (isTabBar) { // 示例二
        BWTabBarViewController *tabBarVC = [BWTabBarViewController new];
        BWDrawViewController *drawVC = [[BWDrawViewController alloc] initWithRootVC:tabBarVC leftVC:leftVC rightVC:rightVC];
        return drawVC;
    } else { // 示例一
        BWRootViewController *vc = [BWRootViewController new];
        //配置NavigationBar
        UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:vc];
        [rootNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbarBackImage"] forBarMetrics:UIBarMetricsDefault];
        rootNav.navigationBar.tintColor = [UIColor whiteColor];
        // 改变导航条上面字体的颜色
        [rootNav.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
        BWDrawViewController *drawVC = [[BWDrawViewController alloc] initWithRootVC:rootNav leftVC:leftVC rightVC:rightVC];
        return drawVC;
    }
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
