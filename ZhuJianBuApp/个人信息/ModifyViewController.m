//
//  ModifyViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/10.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ModifyViewController.h"
#import "UserDefaultsUtil.h"
#import "DESCript.h"
#import "LoginViewController.h"

@interface ModifyViewController ()
{
    UITextField *field;
    UIButton *saveBtn;
}
@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [saveBtn setTitle:@"保存" forState:0];
    saveBtn.titleLabel.font = ZJFont(14);
    [saveBtn setTitleColor:[UIColor whiteColor] forState:0];
    [saveBtn addTarget:self action:@selector(modifyInfo) forControlEvents:1<<6];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    field = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, 40)];
    field.borderStyle = UITextBorderStyleNone;
    field.backgroundColor = [UIColor whiteColor];
//    field.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    field.layer.borderWidth = 1.0;
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    space.backgroundColor = [UIColor whiteColor];
    field.leftView = space;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.text = _oldText;
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:field];
    
}

-(void)modifyInfo
{
    if ([field.text isEqualToString:_oldText]) {
        [Util showHudWithView:self.view message:@"内容没有修改，无需保存" hideAfterDelay:1.5];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *userflag = [UserDefaultsUtil getDataForKey:@"username"];
    [params setValue:userflag forKey:@"userflag"];
    
    if ([self.title isEqualToString:@"电话"]) {
        [params setValue:field.text forKey:@"mobilephone"];
    }
    
    if ([self.title isEqualToString:@"邮箱"]) {
        [params setValue:field.text forKey:@"emails"];
    }
    
    if ([self.title isEqualToString:@"身份证号"]) {
        [params setValue:field.text forKey:@"cardno"];
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appusermodifyinfo" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"Info ~ %@",[Util objectToJson:responseObject]);
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            [Util showHudWithView:self.view message:@"修改成功" hideAfterDelay:1];
           
            //回调
            if (_block) {
                _block(field.text);
            }
            
            //延迟1.5秒执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];

    
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
