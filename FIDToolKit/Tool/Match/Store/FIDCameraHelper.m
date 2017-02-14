//
//  FIDCameraHelper.m
//  GG
//
//  Created by Fidetro on 16/8/17.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import "FIDCameraHelper.h"
#import <CoreVideo/CoreVideo.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreImage/CoreImage.h>
#import <ImageIO/ImageIO.h>
#import <AssertMacros.h>
#import <AssetsLibrary/AssetsLibrary.h>
@implementation FIDCameraHelper

static FIDCameraHelper *sharedManager = nil;


- (void) setupAVCapture
{
    NSError *error = nil;
    
    self.session = [AVCaptureSession new];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    else
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
    
    // Select a video device, make an input
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if ( [self.session canAddInput:deviceInput] )
        [self.session addInput:deviceInput];
    


    // Make a video data output
   AVCaptureVideoDataOutput *videoDataOutput = [AVCaptureVideoDataOutput new];
    
    // we want BGRA, both CoreGraphics and OpenGL work well with 'BGRA'
    NSDictionary *rgbOutputSettings = [NSDictionary dictionaryWithObject:
                                       [NSNumber numberWithInt:kCMPixelFormat_32BGRA] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    [videoDataOutput setVideoSettings:rgbOutputSettings];
    [videoDataOutput setAlwaysDiscardsLateVideoFrames:YES]; // discard if the data output queue is blocked (as we process the still image)
    
    // create a serial dispatch queue used for the sample buffer delegate as well as when a still image is captured
    // a serial dispatch queue must be used to guarantee that video frames will be delivered in order
    // see the header doc for setSampleBufferDelegate:queue: for more information
  dispatch_queue_t  videoDataOutputQueue = dispatch_queue_create("VideoDataOutputQueue", DISPATCH_QUEUE_SERIAL);
    [videoDataOutput setSampleBufferDelegate:self queue:videoDataOutputQueue];
    
    if ( [self.session canAddOutput:videoDataOutput] )
        [self.session addOutput:videoDataOutput];

  
    

}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CFDictionaryRef attachments = CMCopyDictionaryOfAttachments(kCFAllocatorDefault, sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    CIImage *ciImage = [[CIImage alloc] initWithCVPixelBuffer:pixelBuffer options:(NSDictionary *)CFBridgingRelease(attachments)];
    self.cameraImage = [UIImage imageWithCIImage:ciImage scale:1.0 orientation:UIImageOrientationRight];
    
    
}

+ (instancetype)manager{
    if (!sharedManager) {
        sharedManager = [[self alloc]init];
        [sharedManager setupAVCapture];
    }
    
    return sharedManager;
}
+ (void) startRunning
{
    [[[self manager] session] startRunning];
}

+ (void) stopRunning{
    [[[self manager] session] stopRunning];
}
- (UIView *) setCameraWithBounds: (CGRect) bounds
{
    UIView *view = [[UIView alloc] initWithFrame:bounds];
    
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession: self.session];
    preview.frame = bounds;
    preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view.layer addSublayer: preview];
    
    return view;
}
+ (UIView *) setCameraWithBounds: (CGRect) bounds
{
    return [[self manager] setCameraWithBounds: (CGRect) bounds];
}
+ (UIImage *) cameraImage
{
    return [[self manager] cameraImage];
}
@end
