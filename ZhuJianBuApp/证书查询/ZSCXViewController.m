//
//  ZSCXViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ZSCXViewController.h"
#import "WyzAlbumViewController.h"
#import "UserDefaultsUtil.h"
#import "UIImageView+WebCache.h"

@interface ZSCXViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *zsImageView;

@end

@implementation ZSCXViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"证书查询";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.zsImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped)];
    [self.zsImageView addGestureRecognizer:tap];
    
    [self loadCertificateData];
}

#pragma mark - 加载证书数据
-(void)loadCertificateData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *userflag = [UserDefaultsUtil getDataForKey:@"username"];
    [params setValue:userflag forKey:@"userflag"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appsearchcert" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"Certificate ~ %@",[Util objectToJson:responseObject]);
        
//        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
//            NSString *imgURL = responseObject[@"data"];
//            [self.zsImageView sd_setImageWithURL:[NSURL URLWithString:imgURL]];
//        }
        
        self.zsImageView.image = [UIImage imageNamed:@"zs"];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];
    
}

-(void)imageViewTaped
{
    WyzAlbumViewController *wyzAlbumVC = [[WyzAlbumViewController alloc]init];
    
//    wyzAlbumVC.currentIndex = 1;//这个参数表示当前图片的index，默认是0
    
    wyzAlbumVC.imgArr = [NSMutableArray arrayWithArray:@[self.zsImageView.image]];
//    wyzAlbumVC.imageNameArray = imgNamesArr;//后期传姓名
    
    [self presentViewController:wyzAlbumVC animated:YES completion:nil];
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
