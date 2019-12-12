//
//  BWDrawViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/10.
//  Copyright © 2019 syt. All rights reserved.
// 参考代码：https://github.com/mengxianliang/XLSlideMenu
// 非常感谢

#import "BWDrawViewController.h"

@interface BWDrawViewController ()<UIGestureRecognizerDelegate>

/**
 左侧视图
 */
@property (nonatomic, strong) UIViewController *leftVC;
/**
 右侧视图
 */
@property (nonatomic, strong) UIViewController *rightVC;
/**
 留白宽度
 */
@property (nonatomic, assign) CGFloat emptyWidth;
/**
 遮罩层
 */
@property (nonatomic, strong) UIView *coverView;
/**
 拖拽手势
 */
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end
/**
 菜单的显示区域占屏幕宽度的百分比
 */
static const CGFloat MenuWidthScale = 0.8f;
/**
 遮罩层最高透明度
 */
static const CGFloat MaxCoverAlpha = 0.3f;
/**
 快速滑动最小触发速度
 */
static const CGFloat MinActionSpeed = 500;


@implementation BWDrawViewController
{
    CGPoint _originalPoint; // 记录起始位置
}

- (instancetype)initWithRootVC:(UIViewController *)rootVC
{
    self = [super init];
    if (self) {
        _rootVC = rootVC;
        [self setRootVC];
    }
    return self;
}

- (instancetype)initWithRootVC:(UIViewController *)rootVC leftVC:(UIViewController *)leftVC
{
    self = [super init];
    if (self) {
        _rootVC = rootVC;
        [self setRootVC];
        _leftVC = leftVC;
        [self setLeftVC];
    }
    return self;
}

- (instancetype)initWithRootVC:(UIViewController *)rootVC rightVC:(UIViewController *)rightVC
{
    self = [super init];
    if (self) {
        _rootVC = rootVC;
        [self setRootVC];
        _rightVC = rightVC;
        [self setRightVC];
    }
    return self;
}

- (instancetype)initWithRootVC:(UIViewController *)rootVC leftVC:(UIViewController *)leftVC rightVC:(UIViewController *)rightVC
{
    self = [super init];
    if (self) {
        _rootVC = rootVC;
        [self setRootVC];
        _leftVC = leftVC;
        [self setLeftVC];
        _rightVC = rightVC;
        [self setRightVC];
    }
    return self;
}

// 设置主视图
- (void)setRootVC
{
    [self addChildViewController:_rootVC];
    [self.view addSubview:_rootVC.view];
    [_rootVC didMoveToParentViewController:self];
}
// 设置左侧视图
- (void)setLeftVC
{
    // 提前设置ViewController的viewframe，为了懒加载view造成的frame问题，所以通过setter设置了新的view
    _leftVC.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self viewWidth], self.view.bounds.size.height)];
    [_leftVC viewDidLoad];
    [self addChildViewController:_leftVC];
    [self.view insertSubview:_leftVC.view atIndex:0];
    [_leftVC didMoveToParentViewController:self];
}
// 设置右侧视图
- (void)setRightVC
{
    _rightVC.view = [[UIView alloc] initWithFrame:CGRectMake([self emptyWidth], 0, [self viewWidth], self.view.bounds.size.height)];
    //自定义View需要主动调用viewDidLoad
    [_rightVC viewDidLoad];
    [self addChildViewController:_rightVC];
    [self.view insertSubview:_rightVC.view atIndex:0];
    [_rightVC didMoveToParentViewController:self];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateLeftMenuFrame];
    [self updateRightMenuFrame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadPanGesture];
    [self loadCoverView];
    [self loadTapGesture];
}

#pragma mark - 添加拖拽手势
- (void)loadPanGesture
{
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    _pan.delegate = self;
    [self.view addGestureRecognizer:_pan];
}
#pragma mark - 添加遮罩层
- (void)loadCoverView
{
    _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
    _coverView.backgroundColor = UIColor.blackColor;
    _coverView.alpha = 0;
    _coverView.hidden = YES;
}
#pragma mark - 给遮罩层添加轻拍手势
- (void)loadTapGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_coverView addGestureRecognizer:tap];
    [_rootVC.view addSubview:_coverView];
}


#pragma mark - setter方法
- (void)setSlideEnabled:(BOOL)slideEnabled {
    _pan.enabled = slideEnabled;
}

- (BOOL)slideEnabled {
    return _pan.isEnabled;
}




#pragma mark - pan
- (void)pan:(UIPanGestureRecognizer *)pan
{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            // 记录起始位置
            _originalPoint = _rootVC.view.center;
            break;
        case UIGestureRecognizerStateChanged:
            [self panChange:pan];
            break;
            // 滑动结束后，自动归位
        case UIGestureRecognizerStateEnded:
            [self panEnd:pan];
            break;
            
        default:
            break;
    }
}

#pragma mark - tap
- (void)tap
{
    [self showRootVCAnimated:YES];
}
// 拖拽位置改变
- (void)panChange:(UIPanGestureRecognizer *)pan
{
    // 拖拽的距离
    CGPoint translation = [pan translationInView:self.view];
    // 移动主控制器
    _rootVC.view.center = CGPointMake(_originalPoint.x + translation.x, _originalPoint.y);
    // 判断是否设置了左右菜单
    if (!_rightVC && CGRectGetMinX(_rootVC.view.frame) <= 0 ) {
        _rootVC.view.frame = self.view.bounds;
    }
    if (!_leftVC && CGRectGetMinX(_rootVC.view.frame) >= 0) {
        _rootVC.view.frame = self.view.bounds;
    }
    // 滑动到边缘位置后不可以继续滑动
    if (CGRectGetMinX(_rootVC.view.frame) > self.viewWidth) {
        _rootVC.view.center = CGPointMake(_rootVC.view.bounds.size.width / 2 + self.viewWidth, _rootVC.view.center.y);
    }
    if (CGRectGetMaxX(_rootVC.view.frame) < self.emptyWidth) {
        _rootVC.view.center = CGPointMake(_rootVC.view.bounds.size.width / 2 - self.viewWidth, _rootVC.view.center.y);
    }
    // 判断显示左菜单还是右菜单
    if (CGRectGetMinX(_rootVC.view.frame) > 0) {
        //显示左菜单
        [self.view sendSubviewToBack:_rightVC.view];
        //更新左菜单位置
        [self updateLeftMenuFrame];
        //更新遮罩层的透明度
        _coverView.hidden = NO;
        [_rootVC.view bringSubviewToFront:_coverView];
        _coverView.alpha = CGRectGetMinX(_rootVC.view.frame) / self.viewWidth * MaxCoverAlpha;
    } else if (CGRectGetMinX(_rootVC.view.frame) < 0) {
        //显示右菜单
        [self.view sendSubviewToBack:_leftVC.view];
        //更新右侧菜单的位置
        [self updateRightMenuFrame];
        //更新遮罩层的透明度
        _coverView.hidden = NO;
        [_rootVC.view bringSubviewToFront:_coverView];
        _coverView.alpha = (CGRectGetMaxX(self.view.frame) - CGRectGetMaxX(_rootVC.view.frame)) / self.viewWidth * MaxCoverAlpha;
    }
}

- (void)panEnd:(UIPanGestureRecognizer *)pan
{
    //处理快速滑动
    CGFloat speedX = [pan velocityInView:pan.view].x;
    if (ABS(speedX) > MinActionSpeed) {
        [self dealWithFastSliding:speedX];
        return;
    }
    //正常速度
    if (CGRectGetMinX(_rootVC.view.frame) > self.viewWidth / 2) {
        [self showLeftVCAnimated:YES];
    } else if (CGRectGetMaxX(_rootVC.view.frame) < self.viewWidth / 2 + self.emptyWidth){
        [self showRightVCAnimated:YES];
    } else {
        [self showRootVCAnimated:YES];
    }
}

// 处理快速滑动
- (void)dealWithFastSliding:(CGFloat)speedX
{
    //向右滑动
    BOOL swipeRight = speedX > 0;
    //向左滑动
    BOOL swipeLeft = speedX < 0;
    //rootViewController的左边缘位置
    CGFloat rootX = CGRectGetMinX(_rootVC.view.frame);
    if (swipeRight) {//向右滑动
        if (rootX > 0) {//显示左菜单
            [self showLeftVCAnimated:YES];
        }else if (rootX < 0){//显示主菜单
            [self showRootVCAnimated:YES];
        }
    }
    if (swipeLeft) {//向左滑动
        if (rootX < 0) {//显示右菜单
            [self showRightVCAnimated:YES];
        }else if (rootX > 0){//显示主菜单
            [self showRootVCAnimated:YES];
        }
    }
    return;
}


#pragma mark - Delegate
// 设置拖拽响应范围，设置Navigation子视图不可拖拽
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 设置Navigation子视图不可拖拽
    if ([_rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationVC = (UINavigationController *)_rootVC;
        if (navigationVC.viewControllers.count > 1 && navigationVC.interactivePopGestureRecognizer.enabled) {
            return NO;
        }
    }
    // 如果Tabbar的当前视图是UINavigationController，设置UINavigationController子视图不可拖拽
    if ([_rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarVC = (UITabBarController *)_rootVC;
        UINavigationController *navigationVC = tabbarVC.selectedViewController;
        if ([navigationVC isKindOfClass:[UINavigationController class]]) {
            if (navigationVC.viewControllers.count > 1 && navigationVC.interactivePopGestureRecognizer.enabled) {
                return NO;
            }
        }
    }
    // 设置拖拽响应范围
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        // 拖拽响应范围是距离边界是空白位置宽度
        CGFloat actionWidth = [self emptyWidth];
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x <= actionWidth || point.x > self.view.bounds.size.width - actionWidth) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}


// 显示主视图
- (void)showRootVCAnimated:(BOOL)animated
{
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        CGRect frame = self.rootVC.view.frame;
        frame.origin.x = 0.0;
        self.rootVC.view.frame = frame;
        [self updateLeftMenuFrame];
        [self updateRightMenuFrame];
        self.coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.coverView.hidden = YES;
    }];
}
// 显示左侧菜单
- (void)showLeftVCAnimated:(BOOL)animated
{
    if (!_leftVC) {
        return;
    }
    [self.view sendSubviewToBack:_rightVC.view];
    _coverView.hidden = NO;
    [_rootVC.view bringSubviewToFront:_coverView];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        self.rootVC.view.center = CGPointMake(self.rootVC.view.bounds.size.width / 2 + self.viewWidth, self.rootVC.view.center.y);
        self.leftVC.view.frame = CGRectMake(0, 0, [self viewWidth], self.view.bounds.size.height);
        self.coverView.alpha = MaxCoverAlpha;
    }];
}
// 显示右侧菜单
- (void)showRightVCAnimated:(BOOL)animated
{
    if (!_rightVC) {
        return;
    }
    _coverView.hidden = NO;
    [_rootVC.view bringSubviewToFront:_coverView];
    [self.view sendSubviewToBack:_leftVC.view];
    [UIView animateWithDuration:[self animationDurationAnimated:animated] animations:^{
        self.rootVC.view.center = CGPointMake(self.rootVC.view.bounds.size.width / 2 - self.viewWidth, self.rootVC.view.center.y);
        self.rightVC.view.frame = CGRectMake([self emptyWidth], 0, [self viewWidth], self.view.bounds.size.height);
        self.coverView.alpha = MaxCoverAlpha;
    }];
}



#pragma mark - 其他方法
// 更新左侧菜单位置
- (void)updateLeftMenuFrame
{
    _leftVC.view.center = CGPointMake(CGRectGetMinX(_rootVC.view.frame) / 2, _leftVC.view.center.y);
}
// 更新右侧菜单位置
- (void)updateRightMenuFrame
{
    _rightVC.view.center = CGPointMake((self.view.bounds.size.width + CGRectGetMaxX(_rootVC.view.frame)) / 2, _rightVC.view.center.y);
}
// 菜单宽度
- (CGFloat)viewWidth
{
    return MenuWidthScale * self.view.bounds.size.width;
}
// 空白宽度
- (CGFloat)emptyWidth
{
    return self.view.bounds.size.width - self.viewWidth;
}
// 动画时长
- (CGFloat)animationDurationAnimated:(BOOL)animated
{
    return animated ? 0.25 : 0.0;
}
// 取消自动旋转
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}









@end
