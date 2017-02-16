//
//  ForgetPasswordViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ZJInputView.h"
#import "QRadioButton.h"
#import "ZJNetworkingManager.h"
#import "IDyz.h"
#import "UIButton+WebCache.h"
#import "Masonry.h"

@interface ForgetPasswordViewController ()
<QRadioButtonDelegate,
UITextFieldDelegate>
{
    UIView *backView;
    ZJInputView *inputView0;
    ZJInputView *inputView1;
    ZJInputView *inputView2;
    ZJInputView *inputView3;
    ZJInputView *inputView4;
    
//    NSArray *titleArr;
//    NSArray *placeholdArr;
    
    QRadioButton *yxBtn;
    QRadioButton *sjBtn;
    
    UIButton *codeBtn;
    NSInteger count;
    NSTimer *codeTimer;
    
    NSString *flag;
    NSString *numberOrEmail;
    NSString *imgCode;
    NSString *code;
    
    UIButton *imgBtn;
    NSString *imgCodeID;
}
@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找回密码";
    count = 60;
    [self initHeader];
    [self initContentField];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 370, ScreenWidth-30, 50)];
    confirmBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [confirmBtn setTitle:@"确定" forState:0];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
    confirmBtn.titleLabel.font = ZJFont(14);
    [confirmBtn addTarget:self action:@selector(confirmBtnClicked) forControlEvents:1<<6];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.clipsToBounds = YES;
    [self.view addSubview:confirmBtn];
    
    [self loadImageCode];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 初始化Header
-(void)initHeader
{
    UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    headImageV.userInteractionEnabled = YES;
    headImageV.image = [UIImage imageNamed:@"blue"];
    
    BaseBackBtn *backBtn = [[BaseBackBtn alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [backBtn addTarget:self action:@selector(dismissForgetPassword) forControlEvents:1 << 6];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:0];
    [headImageV addSubview:backBtn];

    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-50, 20, 100, 44)];
    titleLab.text = @"找回密码";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = ZJFont(16);
    titleLab.textColor = [UIColor whiteColor];
    [headImageV addSubview:titleLab];
    
    [self.view addSubview:headImageV];
    
}

-(void)dismissForgetPassword
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 初始化ContentField
-(void)initContentField
{
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 250)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    inputView0 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 50)];
    inputView0.leftLab.text = @"类型";
    inputView0.field.enabled = NO;
    [backView addSubview:inputView0];
    
    yxBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"id"];
//    yxBtn.backgroundColor = [UIColor redColor];
    [yxBtn setTitle:@"邮箱" forState:0];
    yxBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [yxBtn setTitleColor:DarkTextColor forState:0];
    yxBtn.titleLabel.font = ZJFont(13);
    [inputView0 addSubview:yxBtn];
    [yxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        
    }];
    
    sjBtn = [[QRadioButton alloc] initWithDelegate:self groupId:@"id"];
//    sjBtn.backgroundColor = [UIColor redColor];
    [sjBtn setTitle:@"手机" forState:0];
    sjBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [sjBtn setTitleColor:DarkTextColor forState:0];
    sjBtn.titleLabel.font = ZJFont(13);
    [inputView0 addSubview:sjBtn];
    [sjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-90);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(50);
        
    }];
    
    inputView1 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 50, ScreenWidth-30, 50)];
    inputView1.leftLab.text = @"用户名";
    inputView1.field.placeholder = @"请输入用户名";
    inputView1.textAlignment = NSTextAlignmentRight;
    [backView addSubview:inputView1];
    
    inputView2 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 100, ScreenWidth-30, 50)];
    inputView2.leftLab.text = @"手机号码";
    inputView2.field.placeholder = @"请输入手机号";
    inputView2.textAlignment = NSTextAlignmentRight;
    [backView addSubview:inputView2];
    
    inputView3 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 150, ScreenWidth-30, 50)];
    inputView3.leftLab.text = @"图片验证码";
    inputView3.field.placeholder = @"";
    inputView3.textAlignment = NSTextAlignmentRight;
    inputView3.field.width = inputView3.field.width - 110;
    [backView addSubview:inputView3];
    
    imgBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [imgBtn addTarget:self action:@selector(loadImageCode) forControlEvents:1<<6];
    [inputView3 addSubview:imgBtn];
    [imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(80);
        
    }];
    
    inputView4 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 200, ScreenWidth-30, 50)];
    inputView4.leftLab.text = @"验证码";
    inputView4.field.placeholder = @"";
    inputView4.field.width = inputView4.field.width - 110;
    inputView4.textAlignment = NSTextAlignmentRight;
    [backView addSubview:inputView4];
    
    UIColor *btnColor = RGB(91, 221, 111);
    codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn addTarget:self action:@selector(getVerificationCode) forControlEvents:1 << 6];
    codeBtn.titleLabel.font = ZJFont(13);
    [codeBtn setTitle:@"获取验证码" forState:0];
    [codeBtn setTitleColor:btnColor forState:0];
    codeBtn.layer.cornerRadius = 3;
    codeBtn.layer.borderColor = btnColor.CGColor;
    codeBtn.layer.borderWidth = 1.0;
    [inputView4 addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(80);
        
    }];
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //userflag直接用inputView1.field.text获取
    
    if (textField.tag == 102) {
        numberOrEmail = textField.text;
    }
    
    if (textField.tag == 103) {
        code = textField.text;
    }
}

#pragma mark - 获取图片验证码
-(void)loadImageCode
{
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appcodecreater" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"restate"]isEqualToString:@"1"])
        {
            NSLog(@"appcodecreater ~ %@",[Util objectToJson:responseObject]);
            
            [imgBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"img"]] forState:0 placeholderImage:[UIImage imageNamed:@"unload_codeView"]];
            imgCodeID = responseObject[@"data"][@"imgid"];
        }
        
        else
        {
            [imgBtn setBackgroundImage:[UIImage imageNamed:@"unload_codeView"] forState:0];
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [imgBtn setBackgroundImage:[UIImage imageNamed:@"unload_codeView"] forState:0];
        //        NSLog(@"服务器异常");
        NSLog(@"获取图片验证码失败");
        
    }];
    
}

#pragma mark - 获取验证码
-(void)getVerificationCode
{
    [self.view endEditing:YES];
    numberOrEmail = inputView2.field.text;
    imgCode = inputView3.field.text;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //手机验证码
    if ([flag isEqualToString:@"0"]) {
        if (numberOrEmail.length != 11) {
            [Util showHudWithView:self.view message:@"请输入正确的手机号" hideAfterDelay:1.5];
            return;
        }
        
        [params setValue:numberOrEmail forKey:@"mobilenumber"];
        [params setValue:@"1" forKey:@"type"];
        [params setValue:imgCode forKey:@"imgcode"];
        [params setValue:imgCodeID forKey:@"imgid"];
        
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appgetvalidcodein" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [hud hideAnimated:YES];
            NSLog(@"手机验证码 ~ %@",[Util objectToJson:responseObject]);
            
            //获取成功
            if ([responseObject[@"restate"] isEqualToString:@"1"]) {
                
                [Util showHudWithView:self.view message:@"获取成功"  hideAfterDelay:1.5];
                codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
                
            }
            
            //获取失败
            else {
                [Util showHudWithView:self.view message:responseObject[@"redes"]  hideAfterDelay:1.5];
            }
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
            [hud hideAnimated:YES];
            NSLog(@"error ~ %@",error);
            
        }];
    }
    
    //邮箱验证码
    else {
        
        if ([inputView1.field.text isEqualToString:@""]) {
            [Util showHudWithView:self.view message:@"请输入用户名" hideAfterDelay:1.5];
            return;
        }
        
        if (![IDyz isValidateEmail:numberOrEmail]) {
            [Util showHudWithView:self.view message:@"请输入正确的邮箱" hideAfterDelay:1.5];
            return;
        }
        
        [params setValue:inputView1.field.text forKey:@"userflag"];
        [params setValue:numberOrEmail forKey:@"email"];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appgetmailcode" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [hud hideAnimated:YES];
            NSLog(@"邮箱验证码 ~ %@",[Util objectToJson:responseObject]);
            
            //获取成功
            if ([responseObject[@"restate"] isEqualToString:@"1"]) {
                
                [Util showHudWithView:self.view message:@"获取成功"  hideAfterDelay:1.5];
                codeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
                
            }
            
            //获取失败
            else {
                [Util showHudWithView:self.view message:responseObject[@"redes"]  hideAfterDelay:1.5];
            }
            
            
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            
            [hud hideAnimated:YES];
            NSLog(@"error ~ %@",error);
            
        }];
        
    }
    
}

- (void)countDown:(UIButton *)btn
{
    if (count == 1)
    {
        codeBtn.userInteractionEnabled = YES;
        [codeBtn setTitle:@"重发验证码" forState:0];
        count = 60;
        [codeTimer invalidate];
    }
    else
    {
        codeBtn.userInteractionEnabled = NO;
        count--;
        NSString *title = [NSString stringWithFormat:@"%ziS", count];
        [codeBtn setTitle:title forState:0];
    }
}

#pragma mark - QRadioButtonDelegate
-(void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    if (radio == yxBtn) {
        NSLog(@"邮箱");
        flag = @"1";
        inputView2.leftLab.text = @"邮箱";
        inputView2.field.placeholder = @"请输入邮箱";
        inputView3.hidden = YES;
        inputView4.frame = CGRectMake(15, 150, ScreenWidth-30, 50);
    }
    
    else {
        NSLog(@"手机");
        flag = @"0";
        inputView2.leftLab.text = @"手机号码";
        inputView2.field.placeholder = @"请输入手机号";
        inputView3.hidden = NO;
        inputView4.frame = CGRectMake(15, 200, ScreenWidth-30, 50);
    }
}

#pragma mark - 确定按钮点击事件
-(void)confirmBtnClicked
{
    [self.view endEditing:YES];
    
    numberOrEmail = inputView2.field.text;
    
    imgCode = inputView3.field.text;
    
    code = inputView4.field.text;
    
    if (!flag) {
        [Util showHudWithView:self.view message:@"请选择类型" hideAfterDelay:1.5];
        return;
    }
    
    if ([inputView1.field.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入用户名" hideAfterDelay:1.5];
        return;
    }
    
    //0是手机 1是邮箱
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:inputView1.field.text forKey:@"userflag"];
    [params setValue:flag forKey:@"flag"];
    [params setValue:code forKey:@"code"];
    
    if ([flag isEqualToString:@"0"]) {
        if (numberOrEmail.length != 11) {
            [Util showHudWithView:self.view message:@"请输入正确的手机号" hideAfterDelay:1.5];
            return;
        }
        
        [params setValue:numberOrEmail forKey:@"mobilephone"];
        [params setValue:@"" forKey:@"email"];
        
    }
    
    else {
        if (![IDyz isValidateEmail:numberOrEmail]) {
            [Util showHudWithView:self.view message:@"请输入正确的邮箱" hideAfterDelay:1.5];
            return;
        }
        
        [params setValue:numberOrEmail forKey:@"email"];
        [params setValue:@"" forKey:@"mobilephone"];
    }
    
    if (code.length != 6) {
        [Util showHudWithView:self.view message:@"请输入正确的验证码" hideAfterDelay:1.5];
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appforgetpwd" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSLog(@"忘记密码 ~ %@",[Util objectToJson:responseObject]);
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            [Util showHudWithView:self.view message:responseObject[@"redes"] hideAfterDelay:1];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];
}



@end
