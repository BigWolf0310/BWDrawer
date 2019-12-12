//
//  BWDrawViewController.h
//  BWDrawerViewController
//
//  Created by syt on 2019/12/10.
//  Copyright © 2019 syt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BWDrawVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BWDrawViewController : UIViewController
/**
 主视图,中心视图
 */
@property (nonatomic, strong) UIViewController *rootVC;
/**
菜单宽度
*/
@property (nonatomic, assign) CGFloat viewWidth;

/**
 是否允许滚动
 */
@property (nonatomic, assign) BOOL slideEnabled;

/**
 创建方法一，单独创建主视图，如果是需要抽屉效果，此创建方法无任何意义，建议使用以下方法
 rootVC 主视图/中心视图（The center view controller）
 */
- (instancetype)initWithRootVC:(UIViewController *)rootVC;
/**
 创建方法二，创建主视图和左侧视图
 rootVC 主视图/中心视图（The center view controller）
 leftVC 左侧视图（The left drawer view controller）
 */
- (instancetype)initWithRootVC:(UIViewController *)rootVC leftVC:(UIViewController *)leftVC;
/**
 创建方法三，创建主视图和右侧视图
 rootVC 主视图/中心视图（The center view controller）
 rightVC 右侧视图（The right drawer view controller）
 */
- (instancetype)initWithRootVC:(UIViewController *)rootVC rightVC:(UIViewController *)rightVC;
/**
 创建方法四，创建主视图、左侧视图和右侧视图
 rootVC 主视图/中心视图（The center view controller）
 leftVC 左侧视图（The left drawer view controller）
 rightVC 右侧视图（The right drawer view controller）
 */
- (instancetype)initWithRootVC:(UIViewController *)rootVC leftVC:(UIViewController *)leftVC rightVC:(UIViewController *)rightVC;

/**
 显示主视图
 */
- (void)showRootVCAnimated:(BOOL)animated;
/**
 显示左侧视图
 */
- (void)showLeftVCAnimated:(BOOL)animated;
/**
 显示右侧视图
 */
- (void)showRightVCAnimated:(BOOL)animated;





@end

NS_ASSUME_NONNULL_END
