//
//  XGMMViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/5.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "XGMMViewController.h"
#import "ZJInputView.h"
#import "DESCript.h"
#import "UserDefaultsUtil.h"
#import "LoginViewController.h"
#import "SRNavigationController.h"

@interface XGMMViewController ()
{
    ZJInputView *inputView0;
    ZJInputView *inputView1;
    ZJInputView *inputView2;
}
@end

@implementation XGMMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    inputView0 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 0, ScreenWidth-30, 50)];
    inputView0.field.secureTextEntry = YES;
    inputView0.textAlignment = NSTextAlignmentRight;
    inputView0.placeholder = @"原密码";
    inputView0.title = @"请输入原密码";
    [backView addSubview:inputView0];
    
    inputView1 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 50, ScreenWidth-30, 50)];
    inputView1.field.secureTextEntry = YES;
    inputView1.textAlignment = NSTextAlignmentRight;
    inputView1.placeholder = @"新密码";
    inputView1.title = @"请输入新密码";
    [backView addSubview:inputView1];
    
    inputView2 = [[ZJInputView alloc] initWithFrame:CGRectMake(15, 100, ScreenWidth-30, 50)];
    inputView2.leftLab.frame = CGRectMake(0, 9, 120, 40);
    inputView2.field.frame = CGRectMake(130, 9, inputView2.width-130, 40);
    inputView2.field.secureTextEntry = YES;
    inputView2.textAlignment = NSTextAlignmentRight;
    inputView2.placeholder = @"确认新密码";
    inputView2.title = @"请输入确认新密码";
    [backView addSubview:inputView2];
    
    UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 180, ScreenWidth-30, 50)];
    changeBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [changeBtn setTitle:@"确认修改" forState:0];
    [changeBtn setTitleColor:[UIColor whiteColor] forState:0];
    changeBtn.titleLabel.font = ZJFont(14);
    [changeBtn addTarget:self action:@selector(confirmChangeBtnClicked) forControlEvents:1<<6];
    changeBtn.layer.cornerRadius = 5;
    changeBtn.clipsToBounds = YES;
    [self.view addSubview:changeBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)confirmChangeBtnClicked
{
 
    [self.view endEditing:YES];
    
    if ([inputView0.field.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入原密码" hideAfterDelay:1.5];
        return;
    }
    
    if ([inputView1.field.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入新密码" hideAfterDelay:1.5];
        return;
    }
    
    if ([inputView2.field.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入确认新密码" hideAfterDelay:1.5];
        return;
    }
    
    if (![inputView2.field.text isEqualToString:inputView1.field.text]) {
        [Util showHudWithView:self.view message:@"确认新密码和新密码输入不一致，请重新输入" hideAfterDelay:1.5];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[UserDefaultsUtil getDataForKey:@"username"] forKey:@"userflag"];
    [params setValue:[DESCript encrypt:inputView0.field.text encryptOrDecrypt:kCCEncrypt key:ZJKey] forKey:@"password"];
    [params setValue:[DESCript encrypt:inputView1.field.text encryptOrDecrypt:kCCEncrypt key:ZJKey] forKey:@"newpwd"];
    [params setValue:[DESCript encrypt:inputView2.field.text encryptOrDecrypt:kCCEncrypt key:ZJKey] forKey:@"confirmpwd"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appusermodifypwd" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSLog(@"Info ~ %@",[Util objectToJson:responseObject]);
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            
            [Util showHudWithView:self.view message:@"修改成功" hideAfterDelay:1];
        
            //删除用户信息 退出登录
            [UserDefaultsUtil removeAllUserDefaults];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                SRNavigationController *nav = [[SRNavigationController alloc] initWithRootViewController:[LoginViewController new]];
                [self presentViewController:nav animated:YES completion:nil];
                
            });
            
        }
        
        else {
            [Util showHudWithView:self.view message:responseObject[@"redes"] hideAfterDelay:1.5];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];

    
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
