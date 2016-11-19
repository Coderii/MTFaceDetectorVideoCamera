//
//  ViewController.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/8/14.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "ViewController.h"
#import "MTFaceDetectorCamera.h"
#import "MTCalculateFaceRect.h"
#import "MTFaceViewManager.h"
#import "YYFPSLabel.h"

#define K_SCREENW [UIScreen mainScreen].bounds.size.width
#define K_SCREENH [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<MTFaceDetectorCameraDelegate>

@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, strong) MTFaceDetectorCamera *videoCamera;

@property (weak, nonatomic) IBOutlet GPUImageView *filterImageView;

@property (weak, nonatomic) IBOutlet UIButton *mirorButton;

@property (nonatomic, assign) BOOL openClose;

@property (nonatomic, assign) NSUInteger faceCount;
@property (nonatomic, strong) UILabel *faceCountLabel;

- (IBAction)mirorClick:(id)sender;
@end

static NSUInteger K_Padding = 10;

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // default
    self.videoCamera = [[MTFaceDetectorCamera alloc] init];
    self.videoCamera.delegate = self;
    
    self.videoCamera.outputImageOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    [self.videoCamera.captureSession setSessionPreset:AVCaptureSessionPresetHigh];    
    [self.videoCamera startCameraCapture];

    // filter View
    self.filterImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;
    
    // add filter
    self.filter = [[GPUImageFilter alloc] init];
    [self.videoCamera addTarget:self.filter];
    [self.filter addTarget:self.filterImageView];
    
    // open detector
    [self.videoCamera openFaceDetector];
    
    // add observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarOrientationChange) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    // YYFPSLabel
    YYFPSLabel *fpsLabel = [YYFPSLabel new];
    CGRect labelFrame = fpsLabel.frame;
    labelFrame.origin.x = self.filterImageView.frame.size.width - labelFrame.size.width - K_Padding;
    labelFrame.origin.y = K_Padding;
    fpsLabel.frame = labelFrame;
    [self.filterImageView addSubview:fpsLabel];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)statusBarOrientationChange {
    self.videoCamera.outputImageOrientation = [[UIApplication sharedApplication] statusBarOrientation];
}

- (void)willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer {
}

- (void)faceDetectorCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    dispatch_async(dispatch_get_main_queue(), ^{
        // faceCount
        self.faceCount = metadataObjects.count;
        
        // faceLabel
        self.faceCountLabel.text = [NSString stringWithFormat:@"人脸数:%@", @(metadataObjects.count)];
        [self.faceCountLabel sizeToFit];
        
        // add faceView
        if (metadataObjects.count != 0) {
            for (NSInteger index = 0; index < metadataObjects.count; index++) {
                AVMetadataFaceObject *faceObj = [metadataObjects objectAtIndex:index];
                
                CGRect rect = [MTCalculateFaceRect calculateFaceRectWithFaceObject:faceObj
                                                                        parentView:self.filterImageView outputImageOrientation:[[UIApplication sharedApplication] statusBarOrientation]
                                                                    cameraPosition:self.videoCamera.cameraPosition
                                                                      cameraMirror:self.videoCamera.horizontallyMirrorFrontFacingCamera];
                [[MTFaceViewManager shareFaceViewManager] showFaceViewAtIndex:index faceCount:metadataObjects.count rect:rect parentView:self.filterImageView];
            }
        }
        else {
            [[MTFaceViewManager shareFaceViewManager] hideAllFaceViewWithParentView:self.filterImageView];
        }
    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.videoCamera rotateCamera];
    
    // hide faceView
    [[MTFaceViewManager shareFaceViewManager] hideAllFaceViewWithParentView:self.filterImageView];
}

- (IBAction)mirorClick:(id)sender {
    self.videoCamera.horizontallyMirrorFrontFacingCamera = !self.videoCamera.horizontallyMirrorFrontFacingCamera;
    self.videoCamera.horizontallyMirrorRearFacingCamera = !self.videoCamera.horizontallyMirrorRearFacingCamera;
}

#pragma mrak - Teardown View

#pragma mark Setter/Getter

- (UILabel *)faceCountLabel {
    if (!_faceCountLabel) {
        _faceCountLabel = [[UILabel alloc] init];
        _faceCountLabel.textColor = [UIColor redColor];
        [self.filterImageView addSubview:_faceCountLabel];
    }
    return _faceCountLabel;
}
@end
