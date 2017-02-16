//
//  GCGZViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "GCGZViewController.h"
#import "TraceView.h"
#import "UserDefaultsUtil.h"
@interface GCGZViewController ()
{
    TraceView *grsqView;
    TraceView *qyhdView;
    TraceView *dfhdView;
    TraceView *bjspView;
    TraceView *qrfbView;
}
@end

@implementation GCGZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"过程跟踪";
    
    [self initUI];
    
    [self loadTraceData];

}

#pragma mark - 初始化界面
-(void)initUI
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth-30, 20)];
    lab.textColor = RGB(9, 131, 207);
    lab.font = ZJFont(14);
    lab.text = @"一级建造师初始申请注册";
    [self.view addSubview:lab];
    
    CGFloat viewHeight = (ScreenHeight-40-64)/5;
    
    grsqView = [[TraceView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, viewHeight) style:TraceViewStyleLeft];
    grsqView.imageName = @"trace_icon01";
    //    grsqView.time = @"";
    grsqView.type = @"个人申请";
    grsqView.block = ^(UIView *view){
        NSLog(@"Tap1");
    };
    [self.view addSubview:grsqView];
    
    qyhdView = [[TraceView alloc] initWithFrame:CGRectMake(0, 40+viewHeight, ScreenWidth, viewHeight) style:TraceViewStyleRight];
    qyhdView.imageName = @"trace_icon02";
    qyhdView.type = @"企业核对";
    qyhdView.block = ^(UIView *view){
        NSLog(@"Tap2");
    };
    [self.view addSubview:qyhdView];
    
    dfhdView = [[TraceView alloc] initWithFrame:CGRectMake(0, 40+viewHeight*2, ScreenWidth, viewHeight) style:TraceViewStyleLeft];
    dfhdView.imageName = @"trace_icon03";
    dfhdView.type = @"地方核对";
    dfhdView.block = ^(UIView *view){
        NSLog(@"Tap3");
    };
    [self.view addSubview:dfhdView];
    
    bjspView = [[TraceView alloc] initWithFrame:CGRectMake(0, 40+viewHeight*3, ScreenWidth, viewHeight) style:TraceViewStyleRight];
    bjspView.imageName = @"trace_icon04";
    bjspView.type = @"部级审批";
    bjspView.block = ^(UIView *view){
        NSLog(@"Tap4");
    };
    [self.view addSubview:bjspView];
    
    qrfbView = [[TraceView alloc] initWithFrame:CGRectMake(0, 40+viewHeight*4, ScreenWidth, viewHeight) style:TraceViewStyleLeft];
    qrfbView.imageName = @"trace_icon05";
    qrfbView.type = @"确认发布";
    qrfbView.block = ^(UIView *view){
        NSLog(@"Tap5");
    };
    [self.view addSubview:qrfbView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载过程跟踪数据
-(void)loadTraceData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *userflag = [UserDefaultsUtil getDataForKey:@"username"];
    [params setValue:userflag forKey:@"userflag"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appprocesstrack" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"Trace ~ %@",[Util objectToJson:responseObject]);
        grsqView.time = @"2017.02.09";
        
        
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
