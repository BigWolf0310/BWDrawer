//
//  BWHeaderView.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/11.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWHeaderView.h"

@interface BWHeaderView ()

@property (nonatomic, strong) UIImageView *bgImgView;
// 背景图片遮罩层
@property (nonatomic, strong) UIView *coverView;
// 二维码
@property (nonatomic, strong) UIButton *QRButton;
// 头像
@property (nonatomic, strong) UIImageView *iconImgView;
// 昵称
@property (nonatomic, strong) UILabel *nickLabel;
// 签名
@property (nonatomic, strong) UILabel *signLabel;

@end


@implementation BWHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews
{
    [self addSubview:self.bgImgView];
    [self addSubview:self.coverView];
    [self addSubview:self.QRButton];
    [self addSubview:self.iconImgView];
    [self addSubview:self.nickLabel];
    [self addSubview:self.signLabel];
}


#pragma mark - QRButtonAction
- (void)QRButtonAction
{
    NSLog(@"二维码扫描");
}





#pragma mark - lazy loading

- (UIImageView *)bgImgView
{
    if (!_bgImgView) {  // bg
        _bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImgView.layer.masksToBounds = YES;
        _bgImgView.image = [UIImage imageNamed:@"bg"];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UIView *)coverView
{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.bgImgView.frame];
        _coverView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:.3];
    }
    return _coverView;
}


- (UIButton *)QRButton
{
    if (!_QRButton) {
        _QRButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _QRButton.frame = CGRectMake(self.bounds.size.width - 50, k_NavBar_Height - 44, 40, 40);
        [_QRButton setImage:[UIImage imageNamed:@"qr"] forState:UIControlStateNormal];
        [_QRButton addTarget:self action:@selector(QRButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _QRButton;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.bounds.size.height / 2 - 30, 60, 60)];
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = 30;
        _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImgView.image = [UIImage imageNamed:@"bg"];
    }
    return _iconImgView;
}

- (UILabel *)nickLabel
{
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImgView.frame) + 10, CGRectGetMinY(self.iconImgView.frame) + 15, self.bounds.size.width - CGRectGetMaxX(self.iconImgView.frame) - 30, 30)];
        _nickLabel.text = @"BigWolf";
        _nickLabel.textColor = UIColor.whiteColor;
        _nickLabel.textAlignment = NSTextAlignmentLeft;
        _nickLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nickLabel;
}

- (UILabel *)signLabel
{
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 , CGRectGetMaxY(self.iconImgView.frame) + 10, self.bounds.size.width - 20, 20)];
        _signLabel.text = @"我就是我，颜色不一样的烟火！";
        _signLabel.textColor = UIColor.whiteColor;
        _signLabel.textAlignment = NSTextAlignmentLeft;
        _signLabel.font = [UIFont systemFontOfSize:14];
    }
    return _signLabel;
}








@end
