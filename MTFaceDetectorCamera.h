//
//  MTFaceDetectorCamera.h
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/15.
//  Copyright © 2016年 meitu. All rights reserved.
//  继承 GPUImageStillCamera

#import <GPUImage/GPUImage.h>

@protocol MTFaceDetectorCameraDelegate<NSObject, GPUImageVideoCameraDelegate>
@optional
- (void)faceDetectorCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection;

@end

@interface MTFaceDetectorCamera : GPUImageStillCamera

/**
 *  开启人脸检测
 */
- (void)openFaceDetector;

/**
 *  关闭人脸检测
 */
- (void)closeFaceDetector;

@property (nonatomic, weak) id<MTFaceDetectorCameraDelegate> delegate;

@end
