//
//  BaseViewController.m
//  
//
//  Created by Fidetro on 16/9/22.
//  Copyright © 2016年 Fidetro. All rights reserved.
//

#import "BaseViewController.h"
//#import "Masonry.h"
#define SystemVersionIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? YES : NO)


#ifdef SystemVersionIOS7
#define BASE_TEXTSIZE(text, font) ([text length] > 0 ? [text sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero)
#else
#define BASE_TEXTSIZE(text, font) ([text length] > 0 ? [text sizeWithFont:font] : CGSizeZero)
#endif
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //顶部不留空
    self.automaticallyAdjustsScrollViewInsets = NO;
    //取消半透明
    self.navigationController.navigationBar.translucent = NO;
    //设置背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //设置导航栏图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"] forBarMetrics:UIBarMetricsDefault];
    
    [self masLayoutSubview];
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}


- (void)hideNavigationBottomLine{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hiden_bg"]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"hiden_bg"];
    self.navigationController.navigationBar.translucent = YES;
    
}




/**
 状态栏变白 要设置info.plist View controller-based status bar appearance  为NO
 */
-(UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleDefault;
    
}
#pragma mark - --------------------------Masonry--------------------------


- (void)fullInSuperViewWithSubView:(UIView *)view{
    
//    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(view.superview);
//    }];
    
}
#pragma mark - 设置NavigationTitle
- (void)setNavigationTitle:(NSString *)title titleColor:(UIColor *)titleColor{
    
    self.title = title;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
    
}
#pragma mark - 左侧按钮设置
- (void)setLeftButtonTitle:(NSString *)title{
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    [self.leftButton setTitle:title forState:UIControlStateNormal];
    [self.leftButton setFrame:CGRectMake(0, 0, BASE_TEXTSIZE(title, self.leftButton.titleLabel.font).width, BASE_TEXTSIZE(title,self.leftButton.titleLabel.font).height)];
}
- (void)setLeftButtonImage:(UIImage *)image{
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    [self.leftButton setImage:image forState:UIControlStateNormal];
    [self.leftButton setFrame:CGRectMake(0, 0, image.size.width,image.size.height)];

    
    
}
#pragma mark - 右侧按钮设置
- (void)setRightButtonTitle:(NSString *)title{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setTitle:title forState:UIControlStateNormal];
    [self.rightButton setFrame:CGRectMake(0, 0, BASE_TEXTSIZE(title, self.rightButton.titleLabel.font).width, BASE_TEXTSIZE(title,self.rightButton.titleLabel.font).height)];

    
}
- (void)setRightButtonImage:(UIImage *)image{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton setImage:image forState:UIControlStateNormal];
    [self.rightButton setFrame:CGRectMake(0, 0, image.size.width,image.size.height)];



}
#pragma mark - --------------------------touch Event--------------------------
- (void)onLeftButtonClick:(id)sender{
  
    if ([self.navigationController.visibleViewController isMemberOfClass:[UITabBarController class]]) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)onRightButtonClick:(id)sender{
    
    
    
}

- (void)refreshEvent{
    
    
}

-(void)touchesEnded:(NSSet<UITouch*> *)touches withEvent:(UIEvent*)event{
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//点击屏幕收起键盘
    
}
#pragma mark - --------------------------get方法--------------------------
- (UIButton *)leftButton{
    
    if (!_leftButton) {
        
        _leftButton = [[UIButton alloc]init];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_leftButton setExclusiveTouch:YES];
        [_leftButton.imageView setContentMode:UIViewContentModeScaleAspectFit];

        [_leftButton addTarget:self action:@selector(onLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _leftButton;
    
}

- (UIButton *)rightButton{
    
    if (!_rightButton) {
        
        _rightButton = [[UIButton alloc]init];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_rightButton setExclusiveTouch:YES];
        [_rightButton.imageView setContentMode:UIViewContentModeScaleAspectFit];

        [_rightButton addTarget:self action:@selector(onRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    return _rightButton;
    
}

- (UIRefreshControl *)refreshControl{
    
    if (!_refreshControl) {
        
        _refreshControl = [[UIRefreshControl alloc]init];

        [_refreshControl addTarget:self action:@selector(refreshEvent) forControlEvents:UIControlEventValueChanged];
        
    }
    
    return _refreshControl;
    
}


- (void)masLayoutSubview{
    
}

- (void)setNavigationStyle{
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
