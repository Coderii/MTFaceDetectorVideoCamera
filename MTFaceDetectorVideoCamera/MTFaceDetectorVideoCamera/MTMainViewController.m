//
//  MTMainViewController.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/9/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MTMainViewController.h"
#import "MTCameraViewController.h"

@interface MTMainViewController()
- (IBAction)cameraSelf:(id)sender;
- (IBAction)beauty:(id)sender;
- (IBAction)video:(id)sender;

@end

@implementation MTMainViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (IBAction)cameraSelf:(id)sender {
    NSLog(@"cameraSelf");
    MTCameraViewController *cameraVC = [[MTCameraViewController alloc] init];
    [self.navigationController pushViewController:cameraVC animated:YES];
}

- (IBAction)beauty:(id)sender {
    NSLog(@"beauty");
}

- (IBAction)video:(id)sender {
    NSLog(@"video");
}
@end
