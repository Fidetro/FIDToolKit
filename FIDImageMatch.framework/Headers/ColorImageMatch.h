//
//  ColorImageMatch.h
//  ARDemo
//
//  Created by Fidetro on 2016/9/28.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ColorImageMatch : NSObject
    
+ (NSInteger)getSuitabilityWithImageA:(UIImage *)imageA imageB:(UIImage *)imageB;
    
@end
