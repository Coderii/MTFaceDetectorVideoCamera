//
//  MTCalculateFaceRect.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/15.
//  Copyright © 2016年 meitu. All rights reserved.
//  人脸位置计算的类

#import "MTCalculateFaceRect.h"

@implementation MTCalculateFaceRect

#pragma mark - Public Methods

+ (CGRect)calculateFaceRectWithFaceObject:(AVMetadataFaceObject *)faceObjcet
                               parentView:(UIView *)parentView
                   outputImageOrientation:(UIInterfaceOrientation)orientation
                           cameraPosition:(AVCaptureDevicePosition)cameraPosition
                             cameraMirror:(BOOL)mirror {
    switch (orientation) {
        case UIInterfaceOrientationUnknown: {
            return CGRectZero;
            break;
        }
        case UIInterfaceOrientationPortrait: {
            return [self sizeForOrientationPortraitFaceObject:faceObjcet parentView:parentView cameraPosition:cameraPosition cameraMirror:mirror];
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown: {
            return [self sizeForOrientationPortraitUpsideDownFaceObject:faceObjcet parentView:parentView cameraPosition:cameraPosition cameraMirror:mirror];
            break;
        }
        case UIInterfaceOrientationLandscapeLeft: {
            return  [self sizeForOrientationLandscapeLeftFaceObject:faceObjcet parentView:parentView cameraPosition:cameraPosition cameraMirror:mirror];
            break;
        }
        case UIInterfaceOrientationLandscapeRight: {
            return [self sizeForOrientationLandscapeRightFaceObject:faceObjcet parentView:parentView cameraPosition:cameraPosition cameraMirror:mirror];
            break;
        }
    }
}

#pragma mark - Private Methods

// front device position
+ (CGRect)sizeForOrientationPortraitFaceObject:(AVMetadataFaceObject *)faceObjcet parentView:(UIView *)parentView cameraPosition:(AVCaptureDevicePosition)cameraPosition cameraMirror:(BOOL)mirror {
    // UIInterfaceOrientationPortrait
    CGFloat centerX;
    
    if (mirror) {
        centerX = parentView.bounds.size.width * (faceObjcet.bounds.origin.y + faceObjcet.bounds.size.height * 0.5);
    }
    else {
        centerX = parentView.bounds.size.width * (1 - faceObjcet.bounds.origin.y - faceObjcet.bounds.size.height * 0.5);
    }
    
    CGFloat centerY = parentView.bounds.size.height * (faceObjcet.bounds.origin.x + faceObjcet.bounds.size.width * 0.5);
    
    CGFloat faceW = parentView.bounds.size.width * faceObjcet.bounds.size.height;
    CGFloat faceH = parentView.bounds.size.height * faceObjcet.bounds.size.width;
    
    CGFloat faceX = centerX - faceW * 0.5;
    CGFloat faceY = centerY - faceH * 0.5;
    
    return CGRectMake(faceX, faceY, faceW, faceH);
}

+ (CGRect)sizeForOrientationPortraitUpsideDownFaceObject:(AVMetadataFaceObject *)faceObjcet parentView:(UIView *)parentView cameraPosition:(AVCaptureDevicePosition)cameraPosition cameraMirror:(BOOL)mirror {
    // UIInterfaceOrientationPortraitUpsideDown
    CGFloat centerX;
    
    if (mirror) {
        centerX = parentView.bounds.size.width * (1 - faceObjcet.bounds.origin.y - faceObjcet.bounds.size.height * 0.5);
    }
    else {
        centerX = parentView.bounds.size.width * (faceObjcet.bounds.origin.y + faceObjcet.bounds.size.height * 0.5);
    }
    CGFloat centerY = parentView.bounds.size.height * (1 - faceObjcet.bounds.origin.x - faceObjcet.bounds.size.width * 0.5);
    
    CGFloat faceW = parentView.bounds.size.width * faceObjcet.bounds.size.height;
    CGFloat faceH = parentView.bounds.size.height * faceObjcet.bounds.size.width;
    
    CGFloat faceX = centerX - faceW * 0.5;
    CGFloat faceY = centerY - faceH * 0.5;
    
    return CGRectMake(faceX, faceY, faceW, faceH);
}

+ (CGRect)sizeForOrientationLandscapeLeftFaceObject:(AVMetadataFaceObject *)faceObjcet parentView:(UIView *)parentView cameraPosition:(AVCaptureDevicePosition)cameraPosition cameraMirror:(BOOL)mirror {
    // UIInterfaceOrientationLandscapeLeft
    CGFloat centerX;
    CGFloat centerY;
    
    if (cameraPosition == AVCaptureDevicePositionFront) {   // DevicePositionFront
        if (mirror) {
            centerX = parentView.bounds.size.width * (1 - faceObjcet.bounds.origin.x - faceObjcet.bounds.size.width * 0.5);
        }
        else {
            centerX = parentView.bounds.size.width * (faceObjcet.bounds.origin.x + faceObjcet.bounds.size.width * 0.5);
        }
        
        centerY = parentView.bounds.size.height * (faceObjcet.bounds.origin.y + faceObjcet.bounds.size.height * 0.5);
    }
    else if (cameraPosition == AVCaptureDevicePositionBack) {   // DevicePositionBack
        centerX = parentView.bounds.size.width * (1 - faceObjcet.bounds.origin.x - faceObjcet.bounds.size.width * 0.5);
        
        if (mirror) {
            centerY = parentView.bounds.size.height * (faceObjcet.bounds.origin.y + faceObjcet.bounds.size.height * 0.5);
        }
        else {
            centerY = parentView.bounds.size.height * (1 - faceObjcet.bounds.origin.y - faceObjcet.bounds.size.height * 0.5);
        }
    }
    else if (cameraPosition == AVCaptureDevicePositionUnspecified) {
        centerX = 0.0f;
        centerY = 0.0f;
    }
    
    CGFloat faceW = parentView.bounds.size.width * faceObjcet.bounds.size.width;
    CGFloat faceH = parentView.bounds.size.height * faceObjcet.bounds.size.height;
    
    CGFloat faceX = centerX - faceW * 0.5;
    CGFloat faceY = centerY - faceH * 0.5;
    
    return CGRectMake(faceX, faceY, faceW, faceH);
}

+ (CGRect)sizeForOrientationLandscapeRightFaceObject:(AVMetadataFaceObject *)faceObjcet parentView:(UIView *)parentView cameraPosition:(AVCaptureDevicePosition)cameraPosition cameraMirror:(BOOL)mirror {
    // UIInterfaceOrientationLandscapeRight
    CGFloat centerX;
    CGFloat centerY;
    
    if (cameraPosition == AVCaptureDevicePositionFront) {   // DevicePositionFront
        if (mirror) {
            centerX = parentView.bounds.size.width * (faceObjcet.bounds.origin.x + faceObjcet.bounds.size.width * 0.5);
        }
        else {
            centerX = parentView.bounds.size.width * (1 - faceObjcet.bounds.origin.x - faceObjcet.bounds.size.width * 0.5);
        }
        centerY = parentView.bounds.size.height * (1 - faceObjcet.bounds.origin.y - faceObjcet.bounds.size.height * 0.5);
    }
    else if (cameraPosition == AVCaptureDevicePositionBack) {   // DevicePositionBack
        centerX = parentView.bounds.size.width * (faceObjcet.bounds.origin.x + faceObjcet.bounds.size.width * 0.5);
        
        if (mirror) {
            centerY = parentView.bounds.size.height * (1 - faceObjcet.bounds.origin.y - faceObjcet.bounds.size.height * 0.5);
        }
        else {
            centerY = parentView.bounds.size.height * (faceObjcet.bounds.origin.y + faceObjcet.bounds.size.height * 0.5);
        }
    }
    else if (cameraPosition == AVCaptureDevicePositionUnspecified) {
        centerX = 0.0f;
        centerY = 0.0f;
    }
    
    CGFloat faceW = parentView.bounds.size.width * faceObjcet.bounds.size.width;
    CGFloat faceH = parentView.bounds.size.height * faceObjcet.bounds.size.height;
    
    CGFloat faceX = centerX - faceW * 0.5;
    CGFloat faceY = centerY - faceH * 0.5;
    
    return CGRectMake(faceX, faceY, faceW, faceH);
}
@end
