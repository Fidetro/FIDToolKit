//
//  BaseViewController.h
//  
//
//  Created by Fidetro on 16/9/22.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UPLOADPATH_BLOCK)(NSString *imagePath);

@interface BaseViewController : UIViewController

/** 返回上传图片地址的block **/
@property(nonatomic,copy) UPLOADPATH_BLOCK uploadPath_block;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIRefreshControl *refreshControl;


/**
 空实现 为了方便写约束
 */
- (void)masLayoutSubview;


/**
 空实现 写导航栏的地方
 */
- (void)setNavigationStyle;

/**
 设置导航栏标题

 @param title      标题
 @param titleColor 字体颜色
 */
- (void)setNavigationTitle:(NSString *)title titleColor:(UIColor *)titleColor;

/**
 隐藏导航栏
 */
- (void)hideNavigationBottomLine;

/**
 让view充满父视图

 @param view view
 */
- (void)fullInSuperViewWithSubView:(UIView *)view;


/**
 设置导航栏左侧按钮标题

 @param title 标题
 */
- (void)setLeftButtonTitle:(NSString *)title;

/**
 设置导航栏左侧按钮图片

 @param image 图片
 */
- (void)setLeftButtonImage:(UIImage *)image;

/**
 设置导航栏右侧按钮标题

 @param title 标题
 */
- (void)setRightButtonTitle:(NSString *)title;

/**
 设置导航栏右侧按钮图片

 @param image 图片
 */
- (void)setRightButtonImage:(UIImage *)image;

/**
 空实现 左侧按钮点击事件

 @param sender button
 */
- (void)onLeftButtonClick:(id)sender;

/**
 空实现 右侧按钮点击事件

 @param sender button
 */
- (void)onRightButtonClick:(id)sender;

/**
 空实现 下拉刷新事件
 */
- (void)refreshEvent;


/**
 写在分类的方法

 @param path_block 返回图片路径
 */
- (void)createActionSheetWithImagePath:(UPLOADPATH_BLOCK)path_block;





@end
