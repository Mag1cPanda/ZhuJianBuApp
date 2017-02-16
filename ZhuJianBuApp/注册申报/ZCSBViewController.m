//
//  ZCSBViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ZCSBViewController.h"
#import "FirstFormViewController.h"

@interface ZCSBViewController ()
<UITableViewDelegate,
UITableViewDataSource>
{
    UITableView *table;
    NSArray *titleArr;
}
@end

@implementation ZCSBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册申报";
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:table];
    
//    [table registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:@"NewsCell"];
    
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    titleArr = @[@"一级建造师初始申请注册表",
                 @"一级注册建造师延续注册申请表",
                 @"一级注册建造师注销申请表",
                 @"二级建造师初始申请注册表",
                 @"一级建造师重新注册申请表",
                 @"一级建造师变更注册申请表",
                 @"一级注册建造师增项注册申请表",];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate & DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstFormViewController *vc = [FirstFormViewController new];
    vc.title = titleArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
