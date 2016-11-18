//
//  MTCalculateFaceRect.h
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/15.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface MTCalculateFaceRect : NSObject

/**
 *  根据参数计算人脸的Rect
 *
 *  @param faceObjcet     一个人脸信息的对象
 *  @param parentView     视频显示的父视图
 *  @param orientation    界面旋转方向
 *  @param cameraPosition 摄像头的位置
 *  @param mirror         是否开启镜像
 *
 *  @return 当前人脸信息的Rect
 */
+ (CGRect)calculateFaceRectWithFaceObject:(AVMetadataFaceObject *)faceObjcet
                               parentView:(UIView *)parentView
                   outputImageOrientation:(UIInterfaceOrientation)orientation
                           cameraPosition:(AVCaptureDevicePosition)cameraPosition
                             cameraMirror:(BOOL)mirror;
@end
