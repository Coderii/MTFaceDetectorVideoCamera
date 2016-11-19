//
//  MTCameraViewController.m
//  MTFaceDetectorVideoCamera
//
//  Created by Cheng on 16/9/6.
//  Copyright © 2016年 meitu. All rights reserved.
//

#import "MTCameraViewController.h"

@implementation MTCameraViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
