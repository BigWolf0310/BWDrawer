//
//  BWMarginButton.m
//  BWDrawerViewController
//
//  Created by syt on 2019/12/12.
//  Copyright © 2019 syt. All rights reserved.
//

#import "BWMarginButton.h"

@interface BWMarginButton ()
{
    float imageWidth;
    float imageHeight;
    float titleWidth;
    float titleHeight;
}


@end


@implementation BWMarginButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleFontValue = 16.0;
        _interval = 0.0;
        self.titleLabel.font = [UIFont systemFontOfSize:self.titleFontValue];
        self.highlighted = NO;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    CGRect rect = [self getRectByString:title];
    titleWidth = rect.size.width;
    titleHeight = rect.size.height;
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    imageWidth = image.size.width;
    imageHeight = image.size.height;
}

#pragma mark - setter方法
- (void)setInterval:(CGFloat)interval
{
    _interval = interval;
}

- (void)setTitleFontValue:(CGFloat)titleFontValue
{
    _titleFontValue = titleFontValue;
    self.titleLabel.font = [UIFont systemFontOfSize:titleFontValue];
}

- (CGRect)getRectByString:(NSString *)string
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_titleFontValue]} context:nil];
    return rect;
}

- (void)setLocationType:(ButtonImageTitleLocationType)locationType
{
    switch (locationType) {
        case 0:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -self.interval * 0.5, 0, self.interval * 0.5);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, self.interval * 0.5, 0, -self.interval * 0.5);
        }
            break;
        case 1:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + self.interval * 0.5, 0, -(titleWidth + self.interval * 0.5));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + self.interval * 0.5), 0, imageWidth + self.interval * 0.5);
        }
            break;
        case 2:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, self.interval, 0, self.interval);
        }
            break;
        case 3:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth + self.interval, 0, -(titleWidth + self.interval));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case 4:
        {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -self.interval, 0, self.interval);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        }
            break;
        case 5:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth, 0, -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + self.interval), 0, imageWidth + self.interval);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case 6:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, titleHeight + self.interval, -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(imageHeight + self.interval, -imageWidth, 0, 0);
            self.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
        }
            break;
        case 7:
        {
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, -(titleHeight + self.interval), -titleWidth);
            self.titleEdgeInsets = UIEdgeInsetsMake(-(imageHeight + self.interval), -imageWidth, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
            
            
        default:
            break;
    }
}











@end
