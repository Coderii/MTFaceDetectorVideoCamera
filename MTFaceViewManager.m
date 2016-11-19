//
//  MTFaceViewManager.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/17.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MTFaceViewManager.h"

#pragma mark - FaceView

@interface MTFaceView : UIView

@end

@implementation MTFaceView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 3.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    // 绘制人脸框
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, rect.size.width, 0);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    CGContextAddLineToPoint(context, 0, rect.size.height);
    CGContextAddLineToPoint(context, 0, 0);
    CGContextStrokePath(context);
}
@end

#pragma mark - FaceViewManager

@interface MTFaceViewManager()

@property (nonatomic, strong) NSMutableDictionary *faceViewDict;

@end

@implementation MTFaceViewManager
static MTFaceViewManager *_singleton = nil;

#pragma mark Life Cycle

- (void)dealloc {
    [self.faceViewDict removeAllObjects];
    self.faceViewDict = nil;
}

+ (instancetype)shareFaceViewManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[self alloc] init];
        _singleton.faceViewDict = [NSMutableDictionary dictionary];
    });
    return _singleton;
}

#pragma mark - Public Methods

- (void)showFaceViewAtIndex:(NSInteger)index faceCount:(NSInteger)count rect:(CGRect)rect parentView:(UIView *)parentView {
    MTFaceView *faceView = [self.faceViewDict objectForKey:@(index)];
    if (faceView) {
        [faceView setHidden:NO];
        faceView.frame = rect;
        [faceView setNeedsDisplay];
    }
    else {
        faceView = [MTFaceView new];
        faceView.backgroundColor = [UIColor clearColor];
        [parentView addSubview:faceView];
        [self.faceViewDict setObject:faceView forKey:@(index)];
    }
    
    // 会有多余的view显示在界面上.需要隐藏
    if (count < self.faceViewDict.allKeys.count) {
        for (NSInteger tmp = count; tmp < self.faceViewDict.allKeys.count; tmp++) {
            [[self.faceViewDict objectForKey:@(tmp)] setHidden:YES];
        }
    }
}

- (void)hideAllFaceViewWithParentView:(UIView *)parentView {
    for (UIView *view in parentView.subviews) {
        if ([view isKindOfClass:[MTFaceView class]]) {
            [view setHidden:YES];
        }
    }
}
@end
