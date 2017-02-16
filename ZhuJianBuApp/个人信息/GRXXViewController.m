//
//  GRXXViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "GRXXViewController.h"
#import "GRXXCell.h"
#import "XGMMViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UserDefaultsUtil.h"
#import "ModifyViewController.h"
#import "LoginViewController.h"
#import "SRNavigationController.h"

static NSString * const ID = @"cell";

@interface GRXXViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    NSArray *titleArr;
    NSArray *contentArr;
    NSArray *iconArr;
    
    UIImageView *icon;
    UILabel *nameLab;
    
    NSString *userflag;
    NSString *mobilephone;
    NSString *emails;
    NSString *cardno;
}
@end

@implementation GRXXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@"电话",@"邮箱",@"身份证号",@"修改密码"];
    iconArr = @[@"info_icon01",@"info_icon02",@"info_icon03",@"info_icon04"];
    contentArr = @[@"",@"",@"",@""];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0,-20, ScreenWidth, ScreenHeight-90) style:UITableViewStylePlain];
    table.tableFooterView = [UIView new];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    table.bounces = NO;
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"GRXXCell" bundle:nil] forCellReuseIdentifier:ID];
    
    
    
    UIButton *logoutBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, ScreenHeight-90, ScreenWidth-30, 50)];
    logoutBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [logoutBtn setTitle:@"退出登录" forState:0];
    [logoutBtn setTitleColor:[UIColor whiteColor] forState:0];
    logoutBtn.titleLabel.font = ZJFont(14);
    [logoutBtn addTarget:self action:@selector(logoutBtnClicked) forControlEvents:1<<6];
    logoutBtn.layer.cornerRadius = 5;
    logoutBtn.clipsToBounds = YES;
    [self.view addSubview:logoutBtn];
    
    
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
//    headerView.alpha = 0.5;
    table.tableHeaderView = headerView;
    
    BaseBackBtn *backBtn = [BaseBackBtn buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 20, 44, 44);
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:1 << 6];
    
    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:0];
    [headerView addSubview:backBtn];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x-50, 31, 100, 20)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"个人信息";
//    titleLab.font = ZJFont(16);
    titleLab.textColor = [UIColor whiteColor];
    [headerView addSubview:titleLab];
    
    
    icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    icon.layer.cornerRadius = 50;
    icon.clipsToBounds = YES;
    icon.image = [UIImage imageNamed:@"header.jpg"];
    icon.center = headerView.center;
    [headerView addSubview:icon];
    
    nameLab = [[UILabel alloc] initWithFrame:CGRectMake(icon.x, icon.maxY+10, 100, 20)];
    nameLab.text = @"黄大平";
//    nameLab.font = ZJFont(16);
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:nameLab];
    
    [self loadInfoData];
}

#pragma mark - 加载个人信息数据
-(void)loadInfoData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    userflag = [UserDefaultsUtil getDataForKey:@"username"];
    [params setValue:userflag forKey:@"userflag"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appsearchuser" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"Info ~ %@",[Util objectToJson:responseObject]);
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            nameLab.text = responseObject[@"data"][@"userflag"];
            mobilephone = responseObject[@"data"][@"mobilephone"];
            emails = responseObject[@"data"][@"emails"];
            cardno = responseObject[@"data"][@"cardno"];
            
            contentArr = @[mobilephone,emails,cardno,@""];
            
            [table reloadData];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];
    
}

#pragma mark - 退出登录
-(void)logoutBtnClicked
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"message:@"确定退出吗？"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud hideAnimated:YES afterDelay:1];
        
        [UserDefaultsUtil removeAllUserDefaults];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            SRNavigationController *nav = [[SRNavigationController alloc] initWithRootViewController:[LoginViewController new]];
            [self presentViewController:nav animated:YES completion:nil];
            
//            LoginViewController *loginVC = [[LoginViewController alloc] init];
//            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
//            keyWindow.rootViewController = loginVC;
//            [self presentViewController:loginVC animated:YES completion:nil];
            
        });
        
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 返回按钮点击事件
-(void)backBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - LifeCycle
//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GRXXCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.icon.image = [UIImage imageNamed:iconArr[indexPath.row]];
    cell.leftLab.text = titleArr[indexPath.row];
    cell.rightLab.text = contentArr[indexPath.row];
    
    if (indexPath.row == 3) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //修改密码
    if (indexPath.row == 3) {
        XGMMViewController *vc = [XGMMViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    else {
//        ModifyViewController *vc = [ModifyViewController new];
//        vc.title = titleArr[indexPath.row];
//        vc.oldText = contentArr[indexPath.row];
//        vc.block = ^(NSString *info){
//            
//            [self loadInfoData];
//            
//        };
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
//    ModifyViewController *vc = [ModifyViewController new];
//    vc.title = titleArr[indexPath.row];
//    vc.oldText = contentArr[indexPath.row];
//    vc.block = ^(NSString *info){
//        GRXXCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.rightLab.text = info;
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
