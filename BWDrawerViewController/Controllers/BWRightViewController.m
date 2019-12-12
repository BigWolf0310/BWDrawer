//
//  BWRightViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWRightViewController.h"

#import "BWTabBarViewController.h"
#import "BWDetailViewController.h"

@interface BWRightViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation BWRightViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    [self loadSubViews];
}

- (void)loadSubViews
{
    [self.view addSubview:self.tableView];
}



#pragma mark - Delegate
#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:3/255.0f green:102/255.0f blue:214/255.0f alpha:1];
    cell.detailTextLabel.text = [self subTitles][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.drawVC showRootVCAnimated:YES];
    } else if (indexPath.row == 1) {
        [self.drawVC showLeftVCAnimated:YES];
    } else if (indexPath.row == 2) {
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
    } else if (indexPath.row == 3) {
        self.drawVC.slideEnabled = !self.drawVC.slideEnabled;
        [tableView reloadData];
    }
}








#pragma mark - lazy loading

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"显示主界面", @"显示左菜单", @"Push新界面", @"设置滑动开关"];
    }
    return _dataArray;
}

- (NSArray *)subTitles
{
    NSString *subTitle = self.drawVC.slideEnabled ? @"(已打开)" : @"(已关闭)" ;
    return @[@"", @"", @"", subTitle];
}


@end
