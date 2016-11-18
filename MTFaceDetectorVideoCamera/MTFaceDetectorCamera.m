//
//  MTFaceDetectorCamera.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/15.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MTFaceDetectorCamera.h"

@interface MTFaceDetectorCamera()<AVCaptureMetadataOutputObjectsDelegate, GPUImageVideoCameraDelegate> {
    AVCaptureMetadataOutput *metadataOutput;
    dispatch_queue_t metadataQueue;
    
    __weak id<MTFaceDetectorCameraDelegate> _delegate;
}
@end

@implementation MTFaceDetectorCamera
@synthesize delegate = _delegate;

#pragma mark -
#pragma mark Initialization and teardown

- (void)dealloc {
    [self closeFaceDetector];
    [self removeInputsAndOutputs];
    
    metadataOutput = nil;
}

- (instancetype)init {
    self = [self initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    if (!self) {
        return nil;
    }
    
    return self;
}

- (id)initWithSessionPreset:(NSString *)sessionPreset cameraPosition:(AVCaptureDevicePosition)cameraPosition {
    // init supper
    self = [super initWithSessionPreset:sessionPreset cameraPosition:cameraPosition];
    if (!self) {
        return nil;
    }
    
    // set metadataOutput
    [self initializeMetadataOutput];
    
    return self;
}

- (void)removeInputsAndOutputs {
    [self.captureSession removeOutput:metadataOutput];
    
    [super removeInputsAndOutputs];
}

#pragma mark -
#pragma mark Private Methods

- (void)initializeMetadataOutput {
    [self.captureSession beginConfiguration];
    
    metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    if ([self.captureSession canAddOutput:metadataOutput]) {
        [self.captureSession addOutput:metadataOutput];
    }
    // add meteData type
    [metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeFace]];
    
    // init meteData queue
    metadataQueue = dispatch_queue_create("com.meitu.FaceDetector", NULL);
    
    [self.captureSession commitConfiguration];
}

#pragma mark -
#pragma mark Public Methods

- (void)openFaceDetector {
    [metadataOutput setMetadataObjectsDelegate:self queue:metadataQueue];
}

- (void)closeFaceDetector {
    [metadataOutput setMetadataObjectsDelegate:nil queue:dispatch_get_main_queue()];
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (_delegate && [_delegate respondsToSelector:@selector(faceDetectorCaptureOutput:didOutputMetadataObjects:fromConnection:)]) {
        [_delegate faceDetectorCaptureOutput:captureOutput didOutputMetadataObjects:metadataObjects fromConnection:connection];
    }
}

@end
