//
//  ThirdFormViewController.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ThirdFormViewController.h"
#import "ZCSBCell.h"
#import "HTSJCell.h"
#import "WMCustomDatePicker.h"

@interface ThirdFormViewController ()
<UITableViewDelegate,
UITableViewDataSource,
UITextFieldDelegate>
{
    UITableView *table;
    NSMutableArray *titleArr;
    NSArray *sectionTitleArr;
    
    NSMutableDictionary *temDic;//保存输入内容的字典
}
@end

@implementation ThirdFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    temDic = [NSMutableDictionary dictionary];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    backView.backgroundColor = RGB(238, 238, 240);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, ScreenWidth-30, 40)];
    lab.textColor = [UIColor darkGrayColor];
    lab.font = ZJFont(14);
    lab.numberOfLines = 2;
    lab.text = @"本人对申请表内容及申报附件材料的真实性负责，如有虚假，愿承担由此产生的一切法律后果。";
    lab.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:lab];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, lab.maxY+40, ScreenWidth-30, 50)];
    nextBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    [nextBtn setTitle:@"确定提交" forState:0];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:0];
    nextBtn.titleLabel.font = ZJFont(14);
    [nextBtn addTarget:self action:@selector(thirdNextBtnClicked) forControlEvents:1<<6];
    nextBtn.layer.cornerRadius = 5;
    nextBtn.clipsToBounds = YES;
    [backView addSubview:nextBtn];
    
    table.tableFooterView = backView;
    
    [table registerNib:[UINib nibWithNibName:@"ZCSBCell" bundle:nil] forCellReuseIdentifier:@"ZCSBCell"];
    [table registerNib:[UINib nibWithNibName:@"HTSJCell" bundle:nil] forCellReuseIdentifier:@"HTSJCell"];
    
    sectionTitleArr = @[@"一级建造师资格证书专业类别",@"继续教育情况（逾期注册时）",@"一级建造师资格考试合格专业类别",@"建筑企业项目经理资质证书情况",@"其他注册情况",@"现企业聘用合同时间"];
    
    NSArray *arr0 = @[@"资格证书专业类别",@"取得方式",@"证书编号",@"签发日期",@"申请注册专业"];
    NSArray *arr1 = @[@"必修课（学时）",@"选修课（学时）"];
    NSArray *arr2 = @[@"专业类别",@"考试合格证明编号",@"签发日期",@"申请注册专业",@"必修课（学时）",@"选修课（学时）"];//模6
    NSArray *arr3 = @[@"资质证书级别",@"资质证书编号"];
    NSArray *arr4 = @[@"注册证书名称",@"证书编号"];
    NSArray *arr5 = @[@""];
    titleArr = [NSMutableArray arrayWithArray:@[arr0,arr1,arr2,arr3,arr4,arr5]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 5;
            break;
            
        case 1:
            return 2;
            break;
            
        case 2:
            return 6;
            break;
            
        case 3:
            return 2;
            break;
            
        case 4:
            return 2;
            break;
            
        case 5:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    backView.backgroundColor = RGB(238, 238, 240);
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenWidth-30-60, 20)];
    lab.textColor = RGB(9, 131, 207);
    lab.font = ZJFont(14);
    lab.text = sectionTitleArr[section];
    [backView addSubview:lab];
    
    if (section == 2 || section == 3 || section == 4) {
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth-80, 5, 60, 30)];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"btn_add"] forState:0];
        [addBtn setTitle:@"添加" forState:0];
        [addBtn setTitleColor:[UIColor grayColor] forState:0];
        addBtn.titleLabel.font = ZJFont(13);
        [addBtn addTarget:self action:@selector(addBtnClicked) forControlEvents:1<<6];
        [backView addSubview:addBtn];
    }
    
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 5) {
        HTSJCell *cell = [table dequeueReusableCellWithIdentifier:@"HTSJCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        WMCustomDatePicker *fromPicker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) PickerStyle:WMDateStyle_YearMonthDay didSelectedDateFinishBack:^(WMCustomDatePicker *picker, NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
            NSLog(@"%@-%@-%@",year, month, day);
            
            cell.from.text = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
            
        }];
        fromPicker.maxLimitDate = [NSDate date];
        cell.from.inputView = fromPicker;
        
        WMCustomDatePicker *toPicker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) PickerStyle:WMDateStyle_YearMonthDay didSelectedDateFinishBack:^(WMCustomDatePicker *picker, NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
            NSLog(@"%@-%@-%@",year, month, day);
            
            cell.to.text = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
            
        }];
        toPicker.maxLimitDate = [NSDate date];
        cell.to.inputView = toPicker;
        
        return cell;
    }
    
    else {
        
        // 定义唯一标识
//        static NSString *CellIdentifier = @"Cell";
//        // 通过indexPath创建cell实例 每一个cell都是单独的
//        ZCSBCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if (!cell) {
//           [tableView registerNib:[UINib nibWithNibName:@"ZCSBCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
//        }
//        return cell;
        
        ZCSBCell *cell = [table dequeueReusableCellWithIdentifier:@"ZCSBCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.leftLab.text = titleArr[indexPath.section][indexPath.row];
        NSString *key = [NSString stringWithFormat:@"1%zi%zi",indexPath.section,indexPath.row];
        cell.field.text = [temDic objectForKey:key];
        cell.field.delegate = self;
        cell.field.tag = [[NSString stringWithFormat:@"%zi%zi",indexPath.section,indexPath.row] integerValue] + 100;
        
//        if (cell.field.tag == 103 || cell.field.tag == 122) {
//            WMCustomDatePicker *picker = [[WMCustomDatePicker alloc]initWithframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) PickerStyle:WMDateStyle_YearMonthDay didSelectedDateFinishBack:^(WMCustomDatePicker *picker, NSString *year, NSString *month, NSString *day, NSString *hour, NSString *minute, NSString *weekDay) {
//                NSLog(@"%@-%@-%@",year, month, day);
//                cell.field.text = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
//            }];
//            
//            picker.maxLimitDate = [NSDate date];
//            
//            cell.field.inputView = picker;
//            
//            
//            UIImageView *calendar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//            calendar.image = [UIImage imageNamed:@"calendar"];
//            cell.field.rightView = calendar;
//            cell.field.rightViewMode = UITextFieldViewModeAlways;
//        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITextField Delegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *key = [NSString stringWithFormat:@"%zi",textField.tag];
    [temDic setValue:textField.text forKey:key];
}

#pragma mark - 确定按钮点击事件
-(void)thirdNextBtnClicked
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud hideAnimated:YES afterDelay:1.5];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
    });
}

#pragma mark - 添加按钮点击时间
-(void)addBtnClicked
{
    [Util showHudWithView:self.view message:@"正在设计开发中" hideAfterDelay:1.5];
}
@end
