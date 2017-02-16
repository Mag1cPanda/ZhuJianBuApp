//
//  NewsViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCell.h"
#import "NewsDetailViewController.h"
#import "NewModel.h"
#import "MJRefresh.h"

@interface NewsViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *dataArr;
    
    NSMutableDictionary *bean;
    NSInteger page;
    
    BOOL isNoMore;
}
@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新闻资讯";
    dataArr = [NSMutableArray array];
    bean = [NSMutableDictionary dictionary];
    [bean setValue:@"10" forKey:@"pagesize"];
    [bean setValue:@"1" forKey:@"pagenum"];
    page = 1;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    table.tableFooterView = [UIView new];
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        table.mj_footer.state = MJRefreshStateIdle;
        [self refreshNewsData];
        
    }];
    
    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreNewsData];
        
    }];
    
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    [self loadNewsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载新闻数据
-(void)refreshNewsData
{
    [dataArr removeAllObjects];
    [bean setValue:@"1" forKey:@"pagenum"];
    [self loadNewsData];
}

-(void)loadNewsData
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [ZJNetworkingManager POST:ZJServiceIP serviceName:@"appgetnews" params:bean success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [hud hideAnimated:YES];
        [table.mj_header endRefreshing];
        
        NSLog(@"News ~ %@",[Util objectToJson:responseObject]);
        
        if ([responseObject[@"restate"] isEqualToString:@"1"]) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                NewModel *model = [[NewModel alloc] initWithDict:dic];
                [dataArr addObject:model];
                [table reloadData];
            }
            isNoMore = false;
        }
        
        else {
            isNoMore = true;
            table.mj_footer.state = MJRefreshStateNoMoreData;
        }
        
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
        [hud hideAnimated:YES];
        NSLog(@"error ~ %@",error);
        
    }];
    
}

-(void)loadMoreNewsData
{
    page ++;
    if (isNoMore) {
        table.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else{
        [bean setValue:[NSNumber numberWithInteger:page] forKey:@"pagenum"];
        [self loadNewsData];
    }
}

#pragma mark - TableView Delegate & DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (dataArr.count > indexPath.row) {
        NewModel *model = dataArr[indexPath.row];
        cell.model = model;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewModel *model = dataArr[indexPath.row];
    NewsDetailViewController *vc = [NewsDetailViewController new];
    vc.url = model.url;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
