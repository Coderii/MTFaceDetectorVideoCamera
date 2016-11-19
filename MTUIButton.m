//
//  MTUIButton.m
//  MTUIButton_design
//
//  Created by 程鹏 on 16/5/28.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MTUIButton.h"

#define MTUEPSINON 0.000001

@interface MTUIButton() {
    //图片的X,Y
    CGFloat _imgX;
    CGFloat _imgY;
    
    //Label的X,Y和Size
    CGFloat _labelX;
    CGFloat _labelY;
    CGSize _titleSize;
    
    //按钮的Frame
    CGRect _frame;
    CGRect _backgroundImageRect;
}
@end

@implementation MTUIButton

#pragma mark - private
/**
 *  计算图片和文字的内部尺寸
 */
- (void)calculateImageAndLabelFrame {
    NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
    _titleSize = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    if (_horizontalLayout) {
        //左右布局
        if (!_iconRight) {
            //如果图片在左
            _imgX = (self.frame.size.width - self.currentImage.size.width - _titleSize.width) * 0.5 + self.contentEdgeInsets.left - self.contentEdgeInsets.right + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
            
            _labelX = _imgX + self.currentImage.size.width + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
            
        } else {
            //如果图片在右
            _labelX = (self.frame.size.width - _titleSize.width - self.currentImage.size.width) * 0.5 + self.contentEdgeInsets.left - self.contentEdgeInsets.right + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
            
            _imgX = _labelX + _titleSize.width + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
            
        }
        _imgY = (self.frame.size.height - self.currentImage.size.height) * 0.5 + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom + self.contentEdgeInsets.top - self.contentEdgeInsets.bottom;
        
        _labelY = (self.frame.size.height - _titleSize.height) * 0.5 + self.contentEdgeInsets.top - self.contentEdgeInsets.bottom + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
        
    } else {
        //上下布局
        if (_iconDown) {
            //如果图片在下
            _labelY = (self.frame.size.height - _titleSize.height - self.currentImage.size.height) * 0.5 + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom + self.contentEdgeInsets.top - self.contentEdgeInsets.bottom;
            
            _imgY = _labelY + _titleSize.height + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom;
            
        } else {
            //如果图片在上
            _imgY = (self.frame.size.height - self.currentImage.size.height - _titleSize.height) * 0.5 + self.imageEdgeInsets.top - self.imageEdgeInsets.bottom + self.contentEdgeInsets.top - self.contentEdgeInsets.bottom;
            _labelY = _imgY + self.currentImage.size.height + self.titleEdgeInsets.top - self.titleEdgeInsets.bottom;
        }
        //计算Image和Label的X坐标
        _imgX = (self.frame.size.width - self.currentImage.size.width) * 0.5 + self.contentEdgeInsets.left - self.contentEdgeInsets.right + self.imageEdgeInsets.left - self.imageEdgeInsets.right;
        
        _labelX = (self.frame.size.width - _titleSize.width) * 0.5 + self.contentEdgeInsets.left - self.contentEdgeInsets.right + self.titleEdgeInsets.left - self.titleEdgeInsets.right;
    }
}

/**
 *  自动适应按钮的尺寸
 *
 *  @param lrdriection 左右方向（默认为0，表示默认为上下方向）
 */
- (void)automaticAdaptationFrameWithLRDirection:(BOOL)lrdriection {
    if (lrdriection) {
        if (self.currentBackgroundImage) {
            //如果有背景图片
            if (((self.frame.size.width >= -MTUEPSINON) && (self.frame.size.width <= MTUEPSINON))
                && ((self.frame.size.height >= -MTUEPSINON) && (self.frame.size.height <= MTUEPSINON))) {
                
                _frame = self.frame;
                _frame.size = CGSizeMake(self.currentBackgroundImage.size.width,
                                         self.currentBackgroundImage.size.height);;
                self.frame = _frame;
            }
        } else {
            //如果没有背景图片
            CGFloat maxH = self.currentImage.size.height > _titleSize.height ? self.currentImage.size.height : _titleSize.height;
            if (((self.frame.size.width >= -MTUEPSINON) && (self.frame.size.width <= MTUEPSINON))
                && ((self.frame.size.height >= -MTUEPSINON) && (self.frame.size.height <= MTUEPSINON))) {
                _frame = self.frame;
                _frame.size = CGSizeMake(self.currentImage.size.width + _titleSize.width,
                                         maxH);
                self.frame = _frame;
            }
        }
    } else {
        if (self.currentBackgroundImage) {
            //如果有背景图片
            if (((self.frame.size.width >= -MTUEPSINON) && (self.frame.size.width <= MTUEPSINON))
                && ((self.frame.size.height >= -MTUEPSINON) && (self.frame.size.height <= MTUEPSINON))) {
                _frame = self.frame;
                _frame.size = CGSizeMake(self.currentBackgroundImage.size.width,
                                         self.currentBackgroundImage.size.height);
                self.frame = _frame;
            }
        } else {
            //如果没有背景图片
            CGFloat maxW = self.currentImage.size.width > _titleSize.width ? self.currentImage.size.width :_titleSize.width;
            if (((self.frame.size.width >= -MTUEPSINON) && (self.frame.size.width <= MTUEPSINON))
                && ((self.frame.size.height >= -MTUEPSINON) && (self.frame.size.height <= MTUEPSINON))) {
                _frame = self.frame;
                _frame.size = CGSizeMake(maxW,
                                         self.currentImage.size.height + _titleSize.height);
                self.frame = _frame;
            }
        }
    }
}

#pragma mark -  override
- (void)layoutSubviews {
//    NSLog(@"layoutSubviews");
    [self calculateImageAndLabelFrame];
    
    [super layoutSubviews];
}

/**
 *  重写计算图片的Rect的方法
 *
 *  @param 给出的图片Rect
 *
 *  @return Image Rect
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//     NSLog(@"imageRectForContentRect");
    //尺寸自动适应
    [self automaticAdaptationFrameWithLRDirection:_horizontalLayout];
    return CGRectMake(_imgX, _imgY, self.currentImage.size.width, self.currentImage.size.height);;
}

/**
 *  重写计算标题的Rect的方法
 *
 *  @param contentRect 给出的label的Rect
 *
 *  @return Label Rect 
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//     NSLog(@"titleRectForContentRect");
    //尺寸自动适应
    [self automaticAdaptationFrameWithLRDirection:_horizontalLayout];
    return CGRectMake(_labelX, _labelY, _titleSize.width, _titleSize.height);;
}

/**
 *  重写计算background的Rect的方法
 *
 *  @param bounds bounds
 *
 *  @return background Rect
 */
- (CGRect)backgroundRectForBounds:(CGRect)bounds {
    //尺寸自动适应
    [self automaticAdaptationFrameWithLRDirection:_horizontalLayout];
    
    //计算背景图片
    if (_bgAspectFit) {
        //如果背景适应原图
        _backgroundImageRect = CGRectMake(self.frame.size.width * 0.5 - self.currentBackgroundImage.size.width * 0.5,
                                          self.frame.size.height * 0.5 - self.currentBackgroundImage.size.height * 0.5,
                                          self.currentBackgroundImage.size.width,
                                          self.currentBackgroundImage.size.height);
    } else {
        //如果背景不适应原图
        _backgroundImageRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.frame.size.height);
    }
    return _backgroundImageRect;
}
@end