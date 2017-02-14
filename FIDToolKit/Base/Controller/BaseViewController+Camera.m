//
//  BaseViewController+Camera.m
//  MiSterLinShoes
//
//  Created by Fidetro on 2016/11/18.
//  Copyright © 2016年 Dtston. All rights reserved.
//

#import "BaseViewController+Camera.h"
#import <AVFoundation/AVFoundation.h>
#define uploadImagePath [[NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"cameraCaches.jpeg"]

@implementation BaseViewController (Camera)

- (void)createActionSheetWithImagePath:(UPLOADPATH_BLOCK)path_block{
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler: ^(BOOL granted) {
        if (granted) {
          
        } else {
            NSLog(@"%@", @"访问受限");
        }
        
    }];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
            NSLog(@"允许状态");
            break;
        case AVAuthorizationStatusDenied:
             NSLog(@"不允许状态，可以弹出一个alertview提示用户在隐私设置中开启权限");
            break;
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"系统还未知是否访问，第一次开启相机时");
            break;
        default:
            break;
    }
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择" message:@"获取头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相机的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypeCamera)];
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开 图片编辑器 用相册的形式打开
        [self chooseHeadImage:(UIImagePickerControllerSourceTypePhotoLibrary)];
    }];
    
    
    [alert addAction:cancel];
    [alert addAction:camera];
    [alert addAction:photoLibrary];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    self.uploadPath_block = path_block;
    
}
-(void)chooseHeadImage:(UIImagePickerControllerSourceType)type {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTintColor:[UIColor blackColor]];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = type;
    imagePicker.delegate = self;
    
    
    if([[[UIDevice  currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];  // 取出被编辑的图片
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0f);
    
    if (imageData.length > 100 * 1024) {
        if (imageData.length > 1000 * 1024) {
            [UIImageJPEGRepresentation(image, 0.2f) writeToFile:uploadImagePath atomically:YES];
        } else {
            [UIImageJPEGRepresentation(image, 0.4f) writeToFile:uploadImagePath atomically:YES];
        }
    } else {
        [UIImageJPEGRepresentation(image, 1.0f) writeToFile:uploadImagePath atomically:YES];
    }
    
    if (self.uploadPath_block) {
        
    self.uploadPath_block(uploadImagePath);
        
        }
    
}

@end
