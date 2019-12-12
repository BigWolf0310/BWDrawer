//
//  BWMarginButton.h
//  BWDrawerViewController
//
//  Created by syt on 2019/12/12.
//  Copyright © 2019 syt. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ButtonImageLocationLeftAndTotalCenter, // 图片居左，文字居右
    ButtonImageLocationRightAndTotalCenter, // 图片居右，文字居左

    ButtonImageLocationLeftAndTotalLeft, // 图片居左，文字居右，整体居左显示
    ButtonImageLocationRightAndTotalLeft, // 图片居右，文字居左，整体居左显示

    ButtonImageLocationLeftAndTotalRight, // 图片居左，文字居右，整体居右显示
    ButtonImageLocationRightAndTotalRight, // 图片居右，文字居左，整体居右显示
    
    ButtonImageLocationTopAndTotalCenter, // 图片居上，文字居下
    ButtonImageLocationBotomAndTotalCenter // 图片居下，文字居上
    
} ButtonImageTitleLocationType;


@interface BWMarginButton : UIButton
/**
 此属性要最后设置，否则布局不生效
 */
@property (nonatomic, assign) ButtonImageTitleLocationType locationType;
/**以下两个属性要最先设置，要早于设置标题和图片，否则布局有问题*/
@property (nonatomic, assign) CGFloat titleFontValue;
@property (nonatomic, assign) CGFloat interval;




@end

NS_ASSUME_NONNULL_END
