MTFaceDetectorCamera
===
[![Support](https://img.shields.io/badge/ios-7-orange.svg)](https://www.apple.com/nl/ios/)&nbsp;
![platform](https://img.shields.io/badge/platform-ios-ff69b4.svg)&nbsp;

**一个基于GPUImage封装的简单的子类MTFaceDetectorCamera，增加人脸检测功能**  

## Features
- [x] 	GPUImage人脸检测
- [x] 	人脸检测rect根据不同旋转情况计算后的返回

## Requirements
    - iOS 7.0+
    - Xcode 7.3

## Usage example
#### Objective-C

	self.videoCamera = [[MTFaceDetectorCamera alloc] init];
	[self.videoCamera openFaceDetector];
	
	// 在代理方法中返回人脸数据
	- (void)faceDetectorCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
		// 数据处理
	}
	
	// 每一个人脸框的Rect
	CGRect rect = [MTCalculateFaceRect calculateFaceRectWithFaceObject:faceObj 
															parentView:self.filterImageView
															outputImageOrientation:[[UIApplication sharedApplication] statusBarOrientation]                                                           	cameraPosition:self.videoCamera.cameraPosition
															cameraMirror:self.videoCamera.horizontallyMirrorFrontFacingCamera];
											
	
	// 显示人脸框（优化过的）										
	[[MTFaceViewManager shareFaceViewManager] showFaceViewAtIndex:index faceCount:metadataObjects.count rect:rect parentView:self.filterImageView];
	
	// 隐藏所有的人脸框
	[[MTFaceViewManager shareFaceViewManager] hideAllFaceViewWithParentView:self.filterImageView];

## Release History

