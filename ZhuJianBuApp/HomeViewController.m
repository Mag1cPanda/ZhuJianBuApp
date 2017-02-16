//
//  HomeViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "BtnGroupCell.h"
#import "NewsCell.h"
#import "NewsViewController.h"
#import "NewsDetailViewController.h"
#import "ZCSBViewController.h"
#import "GCGZViewController.h"
#import "ZSCXViewController.h"
#import "GRXXViewController.h"
#import "ZZKFViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "NewModel.h"

@interface HomeViewController ()
<UITableViewDelegate,
UITableViewDataSource,
SDCycleScrollViewDelegate,
BtnGroupCellDelegate>
{
    UITableView *table;
    
    UIView *newsHeader;
    
    NSMutableArray *dataArr;
    
    SDCycleScrollView *cycleScrollView;
    
    NSMutableArray *cycleDataArr;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.fd_prefersNavigationBarHidden = YES;
    dataArr = [NSMutableArray array];
    cycleDataArr = [NSMutableArray array];
    
    //网络图片
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) delegate:self placeholderImage:[UIImage imageNamed:@"slide_img"]];
    
    //本地图片
//    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 180) imageNamesGroup:@[@"slide_img",@"slide_img",@"slide_img"]];
    cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"slide_navon"];
    cycleScrollView.pageDotImage = [UIImage imageNamed:@"slide_nav"];
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.autoScrollTimeInterval = 3.0;
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, ScreenHeight+20) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:table];
    
    table.tableHeaderView = cycleScrollView;
    table.tableFooterView = [UIView new];
    
    [table registerClass:[BtnGroupCell class] forCellReuseIdentifier:@"BtnGroupCell"];
    [table registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    
    newsHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    newsHeader.layer.borderColor = RGB(245, 245, 245).CGColor;
    newsHeader.layer.borderWidth = 1.0;
    
    UIView *cutOff = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    cutOff.backgroundColor = RGB(245, 245, 245);
    [newsHeader addSubview:cutOff];
    
    UIImageView *redLine = [[UIImageView alloc] initWithFrame:CGRectMake(8, 15, 2, 20)];
    redLine.image = [UIImage imageNamed:@"redline"];
    [newsHeader addSubview:redLine];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 20)];
    titleLab.textColor = [UIColor darkGrayColor];
    titleLab.font = ZJFont(14);
    titleLab.text = @"新闻资讯";
    [newsHeader addSubview:titleLab];
    
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-60, 10, 60, 30)];
    [moreBtn setTitle:@"更多>>" forState:0];
    [moreBtn setTitleColor:[UIColor lightGrayColor] forState:0];
    moreBtn.titleLabel.font = ZJFont(13);
    [moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:1<<6];
    [newsHeader addSubview:moreBtn];
    
    
    [self loadNewsData];
    [self loadADScrollData];
}

//-(BOOL)prefersStatusBarHidden
//{
//    return YES;
//}
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载循环广告页数据
-(void)loadADScrollData
{
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appcomroundnews" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"ADScrollData ~ %@",[Util objectToJson:responseObject]);
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            
            
            NSMutableArray *imgUrlArr = [NSMutableArray array];
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                [cycleDataArr addObject:dic];
                
                NSString *imgurl = [dic[@"imgurl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [imgUrlArr addObject:imgurl];
            
            }
            
            NSLog(@"imgUrlArr ~ %@",imgUrlArr);
            
            cycleScrollView.imageURLStringsGroup = imgUrlArr;
            
        }
       
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"error ~ %@",error);
        
    }];
}

#pragma mark - 加载新闻数据
-(void)loadNewsData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"5" forKey:@"pagesize"];
    [params setValue:@"1" forKey:@"pagenum"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appgetnews" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        NSLog(@"News ~ %@",[Util objectToJson:responseObject]);
        
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            NewModel *model = [[NewModel alloc] initWithDict:dic];
            [dataArr addObject:model];
            [table reloadData];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];

}

#pragma mark - 更多
-(void)moreBtnClicked
{
    NewsViewController *vc = [NewsViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSDictionary *dic = cycleDataArr[index];
    NewsDetailViewController *vc = [NewsDetailViewController new];
    NSString *url = [dic[@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - BtnGroupCellDelegate
-(void)btnGroup:(BtnGroupCell *)btnGroup didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%zi",index);
    if (index == 0) {
        ZCSBViewController *vc = [ZCSBViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 1) {
        GCGZViewController *vc = [GCGZViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 2) {
        ZSCXViewController *vc = [ZSCXViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 3) {
        ZZKFViewController *vc = [ZZKFViewController new];
        vc.title = @"继续教育";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 4) {
        ZZKFViewController *vc = [ZZKFViewController new];
        vc.title = @"在线考试";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 5) {
        ZZKFViewController *vc = [ZZKFViewController new];
        vc.title = @"合格证明";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (index == 6) {
        GRXXViewController *vc = [GRXXViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - TableView Delegate & DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    else {
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        BtnGroupCell *cell = [BtnGroupCell cellWithTableView:table];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
    
    else {
        NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (dataArr.count > indexPath.row) {
            NewModel *model = dataArr[indexPath.row];
            cell.model = model;
        }
        return cell;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return newsHeader;
    }
    
    else {
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return ScreenWidth*170/375;
    }
    
    else {
        return 60;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40;
    }
    
    else {
        return 10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NewModel *model = dataArr[indexPath.row];
        NewsDetailViewController *vc = [NewsDetailViewController new];
        vc.url = model.url;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
