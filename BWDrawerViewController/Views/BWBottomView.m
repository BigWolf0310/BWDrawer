//
//  BWBottomView.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/12.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWBottomView.h"
#import "BWMarginButton.h"

@interface BWBottomView ()

@property (nonatomic, strong) BWMarginButton *setButton;

@end

@implementation BWBottomView

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
    [self addSubview:self.setButton];
}



#pragma mark - setButtonAction
- (void)setButtonAction
{
    NSLog(@"设置emmmmmm");
}








#pragma mark - lazy loading

- (BWMarginButton *)setButton
{
    if (!_setButton) {
        _setButton = [[BWMarginButton alloc] initWithFrame:CGRectMake(15, self.bounds.size.height / 2 - 30, 80, 60)];
//        _setButton.backgroundColor = UIColor.orangeColor;
        _setButton.interval = 5.0;
        _setButton.titleFontValue = 12.0;
        [_setButton setTitle:@"设置" forState:UIControlStateNormal];
        [_setButton setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
        _setButton.locationType = ButtonImageLocationTopAndTotalCenter;
        [_setButton addTarget:self action:@selector(setButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setButton;
}








@end
