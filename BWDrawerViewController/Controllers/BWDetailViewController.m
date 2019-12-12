//
//  BWDetailViewController.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWDetailViewController.h"

@interface BWDetailViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BWDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.titleString;
    [self loadSubViews];
}

- (void)loadSubViews
{
    [self.view addSubview:self.contentLabel];
    NSString *content = @"";
    if ([self.titleString isEqualToString:@"开通会员"]) {
        content = @"谁怕谁啊！";
    } else if ([self.titleString isEqualToString:@"我的QQ钱包"]) {
        content = @"兜比脸都干净😜😜😜";
    } else if ([self.titleString isEqualToString:@"我的收藏"]) {
        content = @"空空如也。";
    } else if ([self.titleString isEqualToString:@"我的相册"]) {
        content = @"怀念啊我们的青春啊！";
    } else if ([self.titleString isEqualToString:@"免流量特权"]) {
        content = @"俺们流量无限，想怎么玩就怎么玩！";
    } else {
        content = @"你什么也没看到......";
    }
    self.contentLabel.text = [NSString stringWithFormat:@"%@", content];
}










#pragma makr - lazy loading

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
        _contentLabel.textColor = UIColor.redColor;
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:28];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}







@end
