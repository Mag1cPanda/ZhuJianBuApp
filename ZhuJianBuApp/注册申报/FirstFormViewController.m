//
//  FirstFormViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "FirstFormViewController.h"
#import "ZJInputView.h"
#import "SecondFormViewController.h"
#import "ZJScrollView.h"
#import "SRSelectListView.h"
#import "WMCustomDatePicker.h"

@interface FirstFormViewController ()
<SRSelectListViewDelegate>
{
    ZJScrollView *scroll;
    SRSelectListView *sfzm;
    SRSelectListView *xb;
    UIButton *birthBtn;
    UIButton *graduateBtn;
}
@end

@implementation FirstFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(238, 238, 240);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
    lab.textColor = RGB(9, 131, 207);
    lab.font = ZJFont(14);
    lab.text = @"基本信息";
    [self.view addSubview:lab];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, ScreenHeight-64-60, ScreenWidth-30, 50)];
    nextBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [nextBtn setTitle:@"下一步" forState:0];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:0];
    nextBtn.titleLabel.font = ZJFont(14);
    [nextBtn addTarget:self action:@selector(nextBtnClicked) forControlEvents:1<<6];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.clipsToBounds = YES;
    [self.view addSubview:nextBtn];
    
    [self initScroll];
    
}

-(void)initScroll
{
    scroll = [[ZJScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-110)];
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(ScreenWidth, 700);
    
    NSArray *titleArr = @[@"姓名",
                          @"性别",
                          @"出生年月",
                          @"民族",
                          @"身份证明",
                          @"证件号码",
                          @"毕业院校",
                          @"所学专业",
                          @"毕业时间",
                          @"学历",
                          @"学位",
                          @"手机号码",
                          @"联系电话",
                          @"电子邮箱"];
    
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
                         @"",
                         @"",
                         @""];
    
    for (int i=0; i<14; i++) {
        ZJInputView *inputView = [[ZJInputView alloc] initWithFrame:CGRectMake(15, i*50, ScreenWidth-30, 50)];
        inputView.tag = 100+i;
        inputView.textAlignment = NSTextAlignmentRight;
        inputView.placeholder = tipsArr[i];
        inputView.title = titleArr[i];
        [scroll addSubview:inputView];
        
        //性别选择
        if (i == 1) {
            inputView.field.enabled = false;
            
            xb = [[SRSelectListView alloc] initWithFrame:CGRectMake(inputView.width-60, 0, 60, 50)];
            xb.currentView = scroll;
            xb.dropFont = ZJFont(15);
            xb.title = @"请选择";
            xb.font = [UIFont systemFontOfSize:14];
            xb.textColor = [UIColor darkGrayColor];
            xb.changeTitle = YES;
            xb.showCheckMark = NO;
            xb.delegate = self;
            xb.dataArray = @[@"男",@"女"];
            [inputView addSubview:xb];
        }
        
        //出生年月
        if (i == 2) {
            UIImageView *calendar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            calendar.image = [UIImage imageNamed:@"calendar"];
            inputView.field.rightView = calendar;
            inputView.field.rightViewMode = UITextFieldViewModeAlways;
            
            WMCustomDatePicker *picker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) PickerStyle:WMDateStyle_YearMonthDay didSelectedDateFinishBack:^(WMCustomDatePicker *picker, NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
                NSLog(@"%@-%@-%@",year, month, day);
                inputView.field.text = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
            }];
            
            picker.maxLimitDate = [NSDate date];
            
            inputView.field.inputView = picker;
        }
        
        //身份证明选择
        if (i == 4) {
            inputView.field.enabled = false;
            
            sfzm = [[SRSelectListView alloc] initWithFrame:CGRectMake(inputView.width-80, 0, 80, 50)];
            sfzm.currentView = scroll;
            sfzm.dropFont = ZJFont(15);
            sfzm.title = @"请选择";
            sfzm.font = [UIFont systemFontOfSize:14];
            sfzm.textColor = [UIColor darkGrayColor];
            sfzm.changeTitle = YES;
            sfzm.showCheckMark = NO;
            sfzm.delegate = self;
            sfzm.dataArray = @[@"身份证",@"军官证",@"警官证",@"护照",@"其他"];
            [inputView addSubview:sfzm];
        }
        
        //毕业时间
        if (i == 8) {
            UIImageView *calendar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            calendar.image = [UIImage imageNamed:@"calendar"];
            inputView.field.rightView = calendar;
            inputView.field.rightViewMode = UITextFieldViewModeAlways;
            
            WMCustomDatePicker *picker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) PickerStyle:WMDateStyle_YearMonthDay didSelectedDateFinishBack:^(WMCustomDatePicker *picker, NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
                NSLog(@"%@-%@-%@",year, month, day);
                inputView.field.text = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
            }];
            
            picker.maxLimitDate = [NSDate date];
            
            inputView.field.inputView = picker;
        }
    }
    
    [self.view addSubview:scroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SRSelectListViewDelegate
-(void)selectListView:(SRSelectListView *)selectListView index:(NSInteger)index content:(NSString *)content
{
    NSLog(@"%zi %@",index,content);
    
    if (selectListView == xb) {
        
    }
    
    else {
        
    }
}


#pragma mark - 下一步
-(void)nextBtnClicked
{
    SecondFormViewController *vc = [SecondFormViewController new];
    vc.title = self.title;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
