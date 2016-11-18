//
//  MTFaceViewManager.h
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/17.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface MTFaceViewManager : NSObject

/**
 *  单例方法生成人脸标识View的管理类
 *
 *  @return MTFaceViewManager实例对象
 */
+ (instancetype)shareFaceViewManager;

/**
 *  显示人脸标识View
 *
 *  @param index      人脸的index
 *  @param count      当前屏幕的人脸数
 *  @param rect       人脸View的尺寸
 *  @param parentView 显示的父视图
 */
- (void)showFaceViewAtIndex:(NSInteger)index faceCount:(NSInteger)count rect:(CGRect)rect parentView:(UIView *)parentView;

/**
 *  隐藏所有的FaceView
 *
 *  @param parentView 显示的父视图
 */
- (void)hideAllFaceViewWithParentView:(UIView *)parentView;

@end
