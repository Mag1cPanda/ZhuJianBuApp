//
//  SecondFormViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "SecondFormViewController.h"
#import "ThirdFormViewController.h"
#import "ZJInputView.h"
#import "ZJScrollView.h"

@interface SecondFormViewController ()
{
    ZJScrollView *scroll;
}
@end

@implementation SecondFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(238, 238, 240);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    lab.textColor = RGB(9, 131, 207);
    lab.font = ZJFont(14);
    lab.text = @"聘用企业情况";
    [self.view addSubview:lab];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, ScreenHeight-64-60, ScreenWidth-30, 50)];
    nextBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [nextBtn setTitle:@"下一步" forState:0];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:0];
    nextBtn.titleLabel.font = ZJFont(14);
    [nextBtn addTarget:self action:@selector(secondNextBtnClicked) forControlEvents:1<<6];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.clipsToBounds = YES;
    [self.view addSubview:nextBtn];
    
    scroll = [[ZJScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-110)];
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(ScreenWidth, 600);
    
    NSArray *titleArr = @[@"企业名称",
                          @"企业性质",
                          @"工商注册地",
                          @"法定代表人",
                          @"通讯地址",
                          @"邮政编码",
                          @"联系人",
                          @"联系电话",
                          @"企业类型",
                          @"企业资质类别",
                          @"资质等级",
                          @"资质证书编号"];
    
    NSArray *tipsArr = @[@"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @"",
                         @""];
    
    for (int i=0; i<12; i++) {
        ZJInputView *inputView = [[ZJInputView alloc] initWithFrame:CGRectMake(15, i*50, ScreenWidth-30, 50)];
        inputView.tag = 100+i;
        inputView.textAlignment = NSTextAlignmentRight;
        inputView.placeholder = tipsArr[i];
        inputView.title = titleArr[i];
        [scroll addSubview:inputView];
    }
    
    [self.view addSubview:scroll];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)secondNextBtnClicked
{
    ThirdFormViewController *vc = [ThirdFormViewController new];
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
