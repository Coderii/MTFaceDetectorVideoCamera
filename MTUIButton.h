//
//  MTUIButton.h
//  MTUIButton_design
//
//  Created by 程鹏 on 16/5/28.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface MTUIButton : UIButton
/**
 *  缩放背景图片(默认为0，表示不缩放，保持原有尺寸)
 */
@property (nonatomic, assign) IBInspectable BOOL bgAspectFit;

/**
 *  按钮的布局方式，默认为0，表示为上下布局，默认上下布局
 */
@property (nonatomic, assign) IBInspectable BOOL horizontalLayout;

/**
 *  按钮的布局方式，默认值为NO，该属性在horizontalLayout为YES的情况下生效，表示为左右布局的情况下，默认图片在左
 */
@property (nonatomic, assign) IBInspectable BOOL iconRight;

/**
 *  按钮的布局方式，默认值为NO，该属性在horizontalLayout为 NO的情况下生效，表示为上下布局的情况下，默认图片在上
 */
@property (nonatomic, assign) IBInspectable BOOL iconDown;



@end
