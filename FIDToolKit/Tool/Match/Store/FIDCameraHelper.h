//
//  FIDCameraHelper.h
//  GG
//
//  Created by Fidetro on 16/8/17.
//  Copyright © 2016年 Fidetro. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
@interface FIDCameraHelper : NSObject<AVCaptureVideoDataOutputSampleBufferDelegate>
/** AVCaptureSession **/
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)UIImage *cameraImage;
+ (void) startRunning;
+ (void) stopRunning;

+ (UIImage *) cameraImage;

/**
 Setting CameraBounds and return CameraView

 @param bounds bounds
 @return CameraView
 */
+ (UIView *) setCameraWithBounds: (CGRect) bounds;
@end
