//
//  LoginViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "LoginViewController.h"
#import "LRTextField.h"
#import "RegisterViewController.h"
#import "ForgetPasswordViewController.h"
#import "HomeViewController.h"
#import "SRNavigationController.h"
#import "DESCript.h"
#import "UserDefaultsUtil.h"

@interface LoginViewController ()
{
    BOOL isRemember;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet LRTextField *usrField;
@property (weak, nonatomic) IBOutlet LRTextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *rememberPWD;
@property (weak, nonatomic) IBOutlet UIButton *forgetPWD;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;


@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.fd_prefersNavigationBarHidden = YES;
    
    isRemember = (BOOL)[UserDefaultsUtil getDataForKey:@"isRemember"];
    
    NSLog(@"%d",isRemember);
    
    if (isRemember) {
        _usrField.text = [UserDefaultsUtil getDataForKey:@"username"];
        _pwdField.text = [UserDefaultsUtil getDataForKey:@"password"];
        [self.rememberPWD setImage:[UIImage imageNamed:@"icon_checked02"] forState:0];
    }
    
    else {
        [self.rememberPWD setImage:[UIImage imageNamed:@"icon_nocheck"] forState:0];
    }
    
    self.usrField.placeholder = @"请输入用户名";
    self.pwdField.placeholder = @"请输入密码";
    self.usrField.backgroundColor = [UIColor clearColor];
    self.pwdField.backgroundColor = [UIColor clearColor];
    self.usrField.iconName = @"icon_user";
    self.pwdField.iconName = @"icon_psw";
    
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 记住密码
- (IBAction)rememberPassword:(id)sender {
    isRemember = !isRemember;
    NSLog(@"%d",isRemember);
    
    if (isRemember) {
        [self.rememberPWD setImage:[UIImage imageNamed:@"icon_checked02"] forState:0];
        [UserDefaultsUtil saveNSUserDefaultsForBOOL:YES forKey:@"isRemember"];
    }
    
    else{
        [self.rememberPWD setImage:[UIImage imageNamed:@"icon_nocheck"] forState:0];
        [UserDefaultsUtil saveNSUserDefaultsForBOOL:NO forKey:@"isRemember"];
    }
    
}

#pragma mark - 忘记密码
- (IBAction)forgetPassword:(id)sender {
    ForgetPasswordViewController *vc = [ForgetPasswordViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 登录
- (IBAction)login:(id)sender {
    
    [self.view endEditing:YES];
    
    if ([_usrField.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入用户名" hideAfterDelay:1.5];
        return;
    }
    
    if ([_pwdField.text isEqualToString:@""]) {
        [Util showHudWithView:self.view message:@"请输入密码" hideAfterDelay:1.5];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_usrField.text forKey:@"username"];
    
    NSString *password = [DESCript encrypt:_pwdField.text encryptOrDecrypt:kCCEncrypt key:ZJKey];
    [params setValue:password forKey:@"password"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"applogin" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"登录 ~ %@",[Util objectToJson:responseObject]);
        
        NSDictionary *dic = responseObject;
        //登录成功
        if ([dic[@"restate"] isEqualToString:@"1"]) {
            
            [UserDefaultsUtil saveNSUserDefaultsForObject:_usrField.text forKey:@"username"];
            [UserDefaultsUtil saveNSUserDefaultsForObject:_pwdField.text forKey:@"password"];
            [UserDefaultsUtil saveNSUserDefaultsForBOOL:isRemember forKey:@"isRemember"];
            NSLog(@"登录成功isRemember %d",isRemember);
            if (!isRemember) {
                [UserDefaultsUtil removeDataForKey:@"password"];
            }
            
            SRNavigationController *nav = [[SRNavigationController alloc] init];
            UIWindow *mainWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
            mainWindow.rootViewController = nav;
            HomeViewController *vc = [HomeViewController new];
            [nav pushViewController:vc animated:YES];
        }
        
        //登录失败
        else {
            [Util showHudWithView:self.view message:dic[@"redes"] hideAfterDelay:1.5];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        [Util showHudWithView:self.view message:@"网络错误" hideAfterDelay:1.5];
        NSLog(@"error ~ %@",error);
        
    }];
    
}

#pragma mark - 注册
- (IBAction)registerNow:(id)sender {
    RegisterViewController *vc = [RegisterViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
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
