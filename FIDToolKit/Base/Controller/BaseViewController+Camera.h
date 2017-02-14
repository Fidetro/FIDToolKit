//
//  BaseViewController+Camera.h
//  MiSterLinShoes
//
//  Created by Fidetro on 2016/11/18.
//  Copyright © 2016年 Dtston. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (Camera)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

- (void)createActionSheetWithImagePath:(UPLOADPATH_BLOCK)path_block;
@end
