//
//  RegisterViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZJInputView.h"
#import "BaseBackBtn.h"
#import "ZJNetworkingManager.h"
#import "IDyz.h"
#import "Util.h"
#import "DESCript.h"
#import "SRSelectListView.h"
#import "UIButton+WebCache.h"
#import "RegBtn.h"

@interface RegisterViewController ()
<UIScrollViewDelegate,
SRSelectListViewDelegate,
UITextFieldDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource>
{
    UIScrollView *scroll;
    BOOL isRead;
    UIButton *agreeBtn;
    
    UIButton *codeBtn;
    
    NSString *usertype;
    NSString *userflag;
    NSString *password;
    NSString *confirmpwd;
    NSString *cardno;
    NSString *emails;
    NSString *mobilephone;
    NSString *code;
    
    UIButton *imgBtn;
    NSString *imgCodeID;
    NSString *imgCode;
    
    NSInteger count;
    NSTimer *codeTimer;
    
    NSArray *dataArr;
    
    NSArray *provinceArr;
    NSArray *cityArr;
    NSString *citycodeid;
    UIPickerView *areaPicker;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    count = 60;
    isRead = YES;
    
    [self initHeader];
    [self initScroll];
    
    UIButton *regBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, scroll.maxY+5, ScreenWidth-40, 40)];
    [regBtn setTitle:@"注册" forState:0];
    [regBtn setBackgroundImage:[UIImage imageNamed:@"blue"] forState:0];
    regBtn.titleLabel.font = ZJFont(13);
    regBtn.layer.cornerRadius = 5;
    regBtn.clipsToBounds = YES;
    [self.view addSubview:regBtn];
    
    [regBtn addTarget:self action:@selector(regBtnClicked) forControlEvents:1<<6];
    
    [self loadImageCode];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"areaid" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    dataArr = dic[@"data"];
    cityArr = dic[@"data"][0][@"citylist"];
    NSLog(@"%@",dataArr);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showHudWithView:(UIView *)view Message:(NSString *)message hideAfterDelay:(NSTimeInterval)timeInterval
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:false];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    [hud hideAnimated:false afterDelay:timeInterval];
}

#pragma mark - 获取验证码
-(void)getRegVerificationCode
{
    [self.view endEditing:YES];
    ZJInputView *inputView7 = [self.view viewWithTag:107];
    mobilephone = inputView7.field.text;
    
    ZJInputView *inputView8 = [self.view viewWithTag:108];
    imgCode = inputView8.field.text;
    
    if (mobilephone.length != 11) {
        [self showHudWithView:self.view Message:@"请输入正确的手机号" hideAfterDelay:1.5];
        return;
    }
    
    if (imgCode.length != 4) {
        [self showHudWithView:self.view Message:@"请输入正确的验证码" hideAfterDelay:1.5];
        return;
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"0" forKey:@"type"];
    [params setValue:mobilephone forKey:@"mobilenumber"];
    [params setValue:imgCode forKey:@"imgcode"];
    [params setValue:imgCodeID forKey:@"imgid"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appgetvalidcodein" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        
        NSLog(@"RegYZM ~ %@",[Util objectToJson:responseObject]);
        
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

#pragma mark - 注册
-(void)regBtnClicked
{
    [self.view endEditing:YES];
    //usertype为选择的
    
    ZJInputView *inputView1 = [self.view viewWithTag:101];
    userflag = inputView1.field.text;
    
    ZJInputView *inputView2 = [self.view viewWithTag:102];
    password = inputView2.field.text;
    
    ZJInputView *inputView3 = [self.view viewWithTag:103];
    confirmpwd = inputView3.field.text;
    
    ZJInputView *inputView4 = [self.view viewWithTag:104];
    cardno = inputView4.field.text;
    
    //5为地区选择
    
    ZJInputView *inputView6 = [self.view viewWithTag:106];
    emails = inputView6.field.text;
    
    ZJInputView *inputView7 = [self.view viewWithTag:107];
    mobilephone = inputView7.field.text;
    
    //8为图片验证码
    
    ZJInputView *inputView9 = [self.view viewWithTag:109];
    code = inputView9.field.text;
    
    if (!usertype) {
        [self showHudWithView:self.view Message:@"请选择申请对象" hideAfterDelay:1.5];
        return;
    }
    
    if (userflag.length < 6) {
        [self showHudWithView:self.view Message:@"请输入符合要求的用户名" hideAfterDelay:1.5];
        return;
    }
    
    if (password.length < 6) {
        [self showHudWithView:self.view Message:@"请输入符合要求的密码" hideAfterDelay:1.5];
        return;
    }
    
    if (![confirmpwd isEqualToString:password]) {
        [self showHudWithView:self.view Message:@"两次输入的密码不一致" hideAfterDelay:1.5];
        return;
    }
    
    if (![IDyz validateIDCardNumber:cardno]) {
        [self showHudWithView:self.view Message:@"请输入正确的身份证号" hideAfterDelay:1.5];
        return;
    }
    
    if (citycodeid.length != 4) {
        [self showHudWithView:self.view Message:@"请选择地区" hideAfterDelay:1.5];
        return;
    }
    
    if (![IDyz isValidateEmail:emails]) {
        [self showHudWithView:self.view Message:@"请输入正确的邮箱" hideAfterDelay:1.5];
        return;
    }
    
    if (mobilephone.length != 11) {
        [self showHudWithView:self.view Message:@"请输入正确的手机号" hideAfterDelay:1.5];
        return;
    }
    
    if (code.length != 6) {
        [self showHudWithView:self.view Message:@"请输入正确的手机验证码" hideAfterDelay:1.5];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:usertype forKey:@"usertype"];
    [params setValue:userflag forKey:@"userflag"];
    
    NSString *encryptPwd = [DESCript encrypt:password encryptOrDecrypt:kCCEncrypt key:ZJKey];
    NSString *encryptCPwd = [DESCript encrypt:confirmpwd encryptOrDecrypt:kCCEncrypt key:ZJKey];
    [params setValue:encryptPwd forKey:@"password"];
    [params setValue:encryptCPwd forKey:@"confirmpwd"];
    
    [params setValue:cardno forKey:@"cardno"];
    [params setValue:citycodeid forKey:@"areaids"];
    [params setValue:emails forKey:@"emails"];
    [params setValue:mobilephone forKey:@"mobilephone"];
    [params setValue:code forKey:@"code"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appregisteredin" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"注册 ~ %@",[Util objectToJson:responseObject]);
        NSDictionary *dic = responseObject;
        
        //注册成功dismiss
        if ([dic[@"restate"] isEqualToString:@"1"]) {
            [Util showHudWithView:self.view message:@"注册成功" hideAfterDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
        //注册失败 提示用户原因
        else {
            [self showHudWithView:self.view Message:dic[@"redes"] hideAfterDelay:1.5];
        }
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];

}

#pragma mark - 同意协议
-(void)agreeBtnClicked
{
    isRead = !isRead;
    if (isRead) {
        [agreeBtn setImage:[UIImage imageNamed:@"icon_checked02"] forState:0];
    }
    
    else{
        [agreeBtn setImage:[UIImage imageNamed:@"icon_nocheck"] forState:0];
    }
}

-(void)initHeader
{
    UIImageView *headImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
    headImageV.image = [UIImage imageNamed:@"blue"];
    headImageV.userInteractionEnabled = YES;
    
    BaseBackBtn *backBtn = [[BaseBackBtn alloc] initWithFrame:CGRectMake(20, 40, 44, 44)];
    [backBtn addTarget:self action:@selector(dismissRegister) forControlEvents:1 << 6];
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:0];
    [headImageV addSubview:backBtn];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-130, 40, 120, 80)];
    leftImageView.image = [UIImage imageNamed:@"img01"];
    
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2+10, 40+20, 120, 50)];
    rightImageView.image = [UIImage imageNamed:@"txt_bg"];
    
    UILabel *tipsLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 100, 40)];
    tipsLab.text = @"请填写您的注册信息";
    tipsLab.font = ZJFont(13);
    tipsLab.numberOfLines = 2;
    tipsLab.textColor = [UIColor whiteColor];
    [rightImageView addSubview:tipsLab];
    
    [headImageV addSubview:leftImageView];
    [headImageV addSubview:rightImageView];
    
    [self.view addSubview:headImageV];
}

- (void)dismissRegister
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 初始化Scroll
- (void)initScroll
{
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 140, ScreenWidth, ScreenHeight-140-80)];
    scroll.delegate = self;
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.showsVerticalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(ScreenWidth, 550);//包含注册须知勾选的50
    
    [self.view addSubview:scroll];
    
    NSArray *titleArr = @[@"申请对象",
                          @"用户名",
                          @"密码",
                          @"确认密码",
                          @"身份证号",
                          @"地区",
                          @"邮箱",
                          @"手机号码",
                          @"图片验证码",
                          @"手机验证码"];
    NSArray *tipsArr = @[@"您可以以企业或个人名义申请",
                         @"长度为6到10位的数字或字母",
                         @"6位及以上大小写字母和数字组成",
                         @"6位及以上大小写字母和数字组成",
                         @"请输入您的身份证号",
                         @"请选择您的地区",
                         @"请输入您的邮箱",
                         @"请输入您的手机号码",
                         @"请输入图片验证码",
                         @"请输入手机验证码"];
    
    for (int i=0; i<10; i++) {
        ZJInputView *inputView = [[ZJInputView alloc] initWithFrame:CGRectMake(15, i*50, ScreenWidth-30, 50)];
        inputView.tag = 100+i;
        inputView.textAlignment = NSTextAlignmentRight;
        inputView.placeholder = tipsArr[i];
        inputView.title = titleArr[i];
        [scroll addSubview:inputView];
        
        //申请对象
        if (i == 0) {
            inputView.field.hidden = true;
            
            SRSelectListView *sqdx = [[SRSelectListView alloc] initWithFrame:CGRectMake(inputView.width-80, 0, 80, 50)];
            sqdx.currentView = scroll;
            sqdx.dropFont = ZJFont(15);
            sqdx.title = @"请选择";
            sqdx.font = ZJFont(13);
            sqdx.textColor = [UIColor darkGrayColor];
            sqdx.changeTitle = YES;
            sqdx.showCheckMark = NO;
            sqdx.delegate = self;
            sqdx.dataArray = @[@"个人",@"企业"];
            [inputView addSubview:sqdx];
        }
        
        if (i == 2 || i == 3) {
            inputView.field.secureTextEntry = YES;
        }
        
        if (i == 5) {
            areaPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
            areaPicker.tag = 1000;
            //指定Picker的代理
            areaPicker.dataSource = self;
            areaPicker.delegate = self;
            
            //是否要显示选中的指示器(默认值是NO)
            areaPicker.showsSelectionIndicator = NO;
            
            inputView.field.delegate = self;
            inputView.field.returnKeyType = UIReturnKeyDone;
            inputView.field.inputView = areaPicker;
        }
        
        if (i == 7) {
            inputView.field.keyboardType = UIKeyboardTypePhonePad;
        }
        
        //图片验证码
        if (i == 8) {
            inputView.field.frame = CGRectMake(inputView.field.x,inputView.field.y , inputView.field.width-90, inputView.field.height);
            
            imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(inputView.width-85, 10, 80, 30)];
            [imgBtn addTarget:self action:@selector(loadImageCode) forControlEvents:1<<6];
            [inputView addSubview:imgBtn];
        }
        
        //手机验证码
        if (i == 9) {
            inputView.field.keyboardType = UIKeyboardTypePhonePad;
            
            inputView.field.frame = CGRectMake(inputView.field.x,inputView.field.y , inputView.field.width-90, inputView.field.height);
            
            UIColor *btnColor = RGB(91, 221, 111);
            codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            codeBtn.frame = CGRectMake(inputView.width-85, 10, 80, 30);
            [codeBtn addTarget:self action:@selector(getRegVerificationCode) forControlEvents:1 << 6];
            codeBtn.titleLabel.font = ZJFont(13);
            [codeBtn setTitle:@"获取验证码" forState:0];
            [codeBtn setTitleColor:btnColor forState:0];
            codeBtn.layer.cornerRadius = 3;
            codeBtn.layer.borderColor = btnColor.CGColor;
            codeBtn.layer.borderWidth = 1.0;
            [inputView addSubview:codeBtn];
        }
    }
    
    agreeBtn = [[RegBtn alloc] initWithFrame:CGRectMake(15, 510, 290, 30)];
    [agreeBtn setTitle:@"我已阅读并同意《注册须知》" forState:0];
    [agreeBtn setImage:[UIImage imageNamed:@"icon_checked02"] forState:0];
    [agreeBtn setTitleColor:DarkTextColor forState:0];
    agreeBtn.titleLabel.font = ZJFont(13);
    [scroll addSubview:agreeBtn];
    
    [agreeBtn addTarget:self action:@selector(agreeBtnClicked) forControlEvents:1<<6];
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

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"End");
    citycodeid = [NSString stringWithFormat:@"%@",cityArr[[areaPicker selectedRowInComponent:1]][@"citycodeid"]];
    NSLog(@"%@",citycodeid);
    
    ZJInputView *inputView = [scroll viewWithTag:105];
    inputView.field.text = [NSString stringWithFormat:@"%@ %@",dataArr[[areaPicker selectedRowInComponent:0]][@"proname"],cityArr[[areaPicker selectedRowInComponent:1]][@"cityname"]];
}

#pragma mark - SRSelectListViewDelegate
-(void)selectListView:(SRSelectListView *)selectListView index:(NSInteger)index content:(NSString *)content
{
    //1是个人  2是企业
    NSLog(@"%zi %@",index,content);
    if (index == 0) {
        usertype = @"1";
    }
    
    else {
        usertype = @"2";
    }
}


#pragma mark --- 与DataSource有关的代理方法
//返回列数（必须实现）
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

//返回每列里边的行数（必须实现）
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //如果是第一列
    if (component == 0) {
        //返回省份数组的个数
        return dataArr.count;
    }
    else
    {
        //返回城市数组的个数
        return cityArr.count;
    }
    
}

#pragma mark --- 与处理有关的代理方法
//设置组件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return ScreenWidth/2;
}
//设置组件中每行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
//设置组件中每行的标题row:行
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return dataArr[row][@"proname"];
    }
    else
    {
        return cityArr[row][@"cityname"];
    }
}



//- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {}
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{}

//选中行的事件处理
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    ZJInputView *inputView = [scroll viewWithTag:105];
    
    if (component == 0) {
        cityArr = dataArr[row][@"citylist"];
        //重新加载指定列的数据
        [pickerView reloadComponent:1];
        
        inputView.field.text = [NSString stringWithFormat:@"%@ %@",dataArr[[pickerView selectedRowInComponent:0]][@"proname"],cityArr[[pickerView selectedRowInComponent:1]][@"cityname"]];
        
        citycodeid = [NSString stringWithFormat:@"%@",cityArr[[pickerView selectedRowInComponent:1]][@"citycodeid"]];
        NSLog(@"citycodeid ~ %@",citycodeid);
    }
    
    else
    {
        inputView.field.text = [NSString stringWithFormat:@"%@ %@",dataArr[[pickerView selectedRowInComponent:0]][@"proname"],cityArr[[pickerView selectedRowInComponent:1]][@"cityname"]];
        citycodeid = [NSString stringWithFormat:@"%@",cityArr[[pickerView selectedRowInComponent:1]][@"citycodeid"]];
        NSLog(@"citycodeid ~ %@",citycodeid);
    }
}

@end
