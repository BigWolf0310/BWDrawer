//
//  UIViewController+BWDrawVC.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/10.
//  Copyright © 2019 syt. All rights reserved.
//

#import "UIViewController+BWDrawVC.h"
#import "BWDrawViewController.h"

@implementation UIViewController (BWDrawVC)

- (BWDrawViewController *)drawVC
{
    UIViewController *vc = self.parentViewController;
    while (vc) {
        if ([vc isKindOfClass:[BWDrawViewController class]]) {
            return (BWDrawViewController *)vc;
        } else if (vc.parentViewController && vc.parentViewController != vc) {
            vc = vc.parentViewController;
        } else {
            vc = nil;
        }
    }
    return nil;
}







@end
