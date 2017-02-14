//
//  GreyImageMatch.h
//  Fidetro
//
//  Created by Fidetro on 16/8/15.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GreyImageMatch : NSObject

/**
 *  传入2张图片比较
 *
 *  @param imageA
 *  @param imageB
 *
 *  @return 小于5说明很相似，大于10说明差别很大
 */
+ (NSInteger)getSuitabilityWithImageA:(UIImage *)imageA imageB:(UIImage *)imageB;



@end
