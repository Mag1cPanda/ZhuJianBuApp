//
//  SRNavigationController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "SRNavigationController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"

@interface SRNavigationController ()

@end

@implementation SRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.fd_fullscreenPopGestureRecognizer.enabled = YES;
    
    UIImage *img = [UIImage imageNamed:@"blue"];
    // 指定为拉伸模式，伸缩后重新赋值
    img = [img resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    
    //去除导航栏底部黑线
    [self.navigationBar setShadowImage:[UIImage new]];
    
    //导航栏文字颜色变为白色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //去掉系统自带返回按钮的文字，只保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    //改变返回按钮的颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置原点坐标从标题栏下面开始
//    self.navigationBar.translucent = NO;
    
}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    if (self.viewControllers.count > 1) {
//        self.interactivePopGestureRecognizer.enabled = YES;
//    }else{
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
