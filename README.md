MTFaceDetectorCamera
===
[![Support](https://img.shields.io/badge/ios-7-orange.svg)](https://www.apple.com/nl/ios/)&nbsp;
![platform](https://img.shields.io/badge/platform-ios-ff69b4.svg)&nbsp;

**һ������GPUImage��װ�ļ򵥵�����MTFaceDetectorCamera������������⹦��**  

## Features
- [x] 	GPUImage�������
- [x] 	�������rect���ݲ�ͬ��ת��������ķ���

## Requirements
    - iOS 7.0+
    - Xcode 7.3

## Usage example
#### Objective-C

	self.videoCamera = [[MTFaceDetectorCamera alloc] init];
	[self.videoCamera openFaceDetector];
	
	// �ڴ������з�����������
	- (void)faceDetectorCaptureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
		// ���ݴ���
	}
	
	// ÿһ���������Rect
	CGRect rect = [MTCalculateFaceRect calculateFaceRectWithFaceObject:faceObj 
															parentView:self.filterImageView
															outputImageOrientation:[[UIApplication sharedApplication] statusBarOrientation]                                                           	cameraPosition:self.videoCamera.cameraPosition
															cameraMirror:self.videoCamera.horizontallyMirrorFrontFacingCamera];
											
	
	// ��ʾ�������Ż����ģ�										
	[[MTFaceViewManager shareFaceViewManager] showFaceViewAtIndex:index faceCount:metadataObjects.count rect:rect parentView:self.filterImageView];
	
	// �������е�������
	[[MTFaceViewManager shareFaceViewManager] hideAllFaceViewWithParentView:self.filterImageView];

## Release History

