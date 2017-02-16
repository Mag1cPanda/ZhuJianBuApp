//
//  BtnGroupCell.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "BtnGroupCell.h"
#define BtnWidth ScreenWidth/5
#define BtnHeight ScreenWidth*170/375/2

@implementation BtnGroupCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"status";
    BtnGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[BtnGroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.zcsbBtn = [[ZJButton alloc] initWithFrame:CGRectMake(0, 0, BtnWidth*2, BtnHeight*2)];
    self.zcsbBtn.zj_Text = @"注册申报";
    self.zcsbBtn.zj_Image = [UIImage imageNamed:@"zcsb"];
    [self.zcsbBtn addTarget:self action:@selector(zcsbBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.zcsbBtn];
    UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(self.zcsbBtn.zj_titleLabel.x-10, self.zcsbBtn.zj_titleLabel.maxY, self.zcsbBtn.zj_titleLabel.width+20, self.zcsbBtn.zj_titleLabel.height)];
    detail.textColor = [UIColor lightGrayColor];
    detail.text = @"快速注册申报";
    detail.font = ZJFont(12);
    detail.textAlignment = NSTextAlignmentCenter;
    [self.zcsbBtn addSubview:detail];
    
    
    self.gcgzBtn = [[ZJButton alloc] initWithFrame:CGRectMake(BtnWidth*2, 0, BtnWidth, BtnHeight)];
    self.gcgzBtn.zj_Text = @"过程跟踪";
    self.gcgzBtn.zj_Image = [UIImage imageNamed:@"gcgz"];
    [self.gcgzBtn addTarget:self action:@selector(gcgzBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.gcgzBtn];
    
    self.zscxBtn = [[ZJButton alloc] initWithFrame:CGRectMake(self.gcgzBtn.maxX, 0, BtnWidth, BtnHeight)];
    self.self.zscxBtn.zj_Text = @"证书查询";
    self.self.zscxBtn.zj_Image = [UIImage imageNamed:@"zscx"];
    [self.zscxBtn addTarget:self action:@selector(zscxbBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.zscxBtn];
    
    self.jxjyBtn = [[ZJButton alloc] initWithFrame:CGRectMake(self.zscxBtn.maxX, 0, BtnWidth, BtnHeight)];
    self.self.jxjyBtn.zj_Text = @"继续教育";
    self.self.jxjyBtn.zj_Image = [UIImage imageNamed:@"jxjy"];
    [self.jxjyBtn addTarget:self action:@selector(jxjyBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.jxjyBtn];
    
    
    CGFloat secondY =  self.gcgzBtn.maxY;
    self.zxksBtn = [[ZJButton alloc] initWithFrame:CGRectMake(self.zcsbBtn.maxX, secondY, BtnWidth, BtnHeight)];
    self.self.zxksBtn.zj_Text = @"在线考试";
    self.self.zxksBtn.zj_Image = [UIImage imageNamed:@"zxks"];
    [self.zxksBtn addTarget:self action:@selector(zxksBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.zxksBtn];
    
    self.hgzmBtn = [[ZJButton alloc] initWithFrame:CGRectMake(self.zxksBtn.maxX, secondY, BtnWidth, BtnHeight)];
    self.self.hgzmBtn.zj_Text = @"合格证明";
    self.self.hgzmBtn.zj_Image = [UIImage imageNamed:@"hgzm"];
    [self.hgzmBtn addTarget:self action:@selector(hgzmBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.hgzmBtn];
    
    self.grxxBtn = [[ZJButton alloc] initWithFrame:CGRectMake(self.hgzmBtn.maxX, secondY, BtnWidth, BtnHeight)];
    self.self.grxxBtn.zj_Text = @"个人信息";
    self.self.grxxBtn.zj_Image = [UIImage imageNamed:@"grxx"];
    [self.grxxBtn addTarget:self action:@selector(grxxBtnClicked) forControlEvents:1<<6];
    [self addSubview:self.grxxBtn];
}

#pragma mark - 按钮点击事件
-(void)zcsbBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:0];
    }
}

-(void)gcgzBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:1];
    }
}

-(void)zscxbBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:2];
    }
}

-(void)jxjyBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:3];
    }
}

-(void)zxksBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:4];
    }
}


-(void)hgzmBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:5];
    }
}


-(void)grxxBtnClicked
{
    if (_delegate && [_delegate respondsToSelector:@selector(btnGroup:didSelectItemAtIndex:)]) {
        [_delegate btnGroup:self didSelectItemAtIndex:6];
    }
}


@end
