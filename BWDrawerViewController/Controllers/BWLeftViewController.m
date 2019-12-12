//
//  BWLeftViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWLeftViewController.h"
#import "BWTabBarViewController.h"
#import "BWDetailViewController.h"

#import "BWHeaderView.h"
#import "BWBottomView.h"

@interface BWLeftViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BWHeaderView *headerView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) BWBottomView *bottomView;

@end

@implementation BWLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadSubViews];
}

- (void)loadSubViews
{
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
}









#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.backgroundColor = UIColor.clearColor;
    cell.textLabel.textColor = UIColor.whiteColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.imageView.layer.masksToBounds = YES;
    
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.imageArray[indexPath.row]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.drawVC showRootVCAnimated:YES];
    BWDetailViewController *detailVC = [BWDetailViewController new];
    detailVC.titleString = self.dataArray[indexPath.row];
    id vc = self.drawVC.rootVC;
    if ([vc isKindOfClass:[UINavigationController class]]) { // 常规的导航控制器
        UINavigationController *nav = (UINavigationController *)vc;
        [nav pushViewController:detailVC animated:NO];
    } else if ([vc isKindOfClass:[BWTabBarViewController class]]) { // TabBar导航控制器
        BWTabBarViewController *tabBarVC = (BWTabBarViewController *)vc;
        NSArray *childs = tabBarVC.childViewControllers;
        if ([childs[tabBarVC.selectedIndex] isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)childs[tabBarVC.selectedIndex];
            UIViewController *childVC = nav.childViewControllers.firstObject;
            childVC.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:detailVC animated:NO];
            childVC.hidesBottomBarWhenPushed = NO;
        }
    }
}




#pragma mark - lazy loading

- (BWHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[BWHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150 + k_NavBar_Height - 44)];
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.bounds.size.width, kHeight - CGRectGetMaxY(self.headerView.frame) - 80 - k_TabBar_DValue_Height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.4];
        _tableView.tableFooterView = [UIView new];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = @[@"vip", @"wallet", @"draw", @"collect", @"photo", @"file", @"signal"];
    }
    return _imageArray;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"开通会员", @"我的QQ钱包", @"我的个性装扮", @"我的收藏", @"我的相册", @"我的文件", @"免流量特权"];
    }
    return _dataArray;
}

- (BWBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BWBottomView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), kWidth, 80 + k_TabBar_DValue_Height)];
        _bottomView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.4];
    }
    return _bottomView;
}




@end
