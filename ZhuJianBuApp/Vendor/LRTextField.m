//
//  LRTextField.m
//  CZT_IOS_Longrise
//
//  Created by Mag1cPanda on 16/5/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import "LRTextField.h"

@implementation LRTextField


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.font = [UIFont systemFontOfSize:14];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.leftView = self.imageView;
}

-(void)setIconName:(NSString *)iconName
{
    self.imageView.image = [UIImage imageNamed:iconName];
}

//在view绘制的时候添加底部横线
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, rect.size.height-2, rect.size.width, 1)];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];
}

//控制清除按钮的位置
//-(CGRect)clearButtonRectForBounds:(CGRect)bounds
//{
//    return CGRectMake(bounds.origin.x + bounds.size.width - 50, bounds.origin.y + bounds.size.height -20, 16, 16);
//}

//控制placeHolder的位置，左右缩20

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x+50, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+50, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +50, bounds.origin.y, bounds.size.width -10, bounds.size.height);
    return inset;
}

//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x + 20, bounds.size.height/2-10, 20, 20);
    return inset;
}



//控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//CGContextRef context = UIGraphicsGetCurrentContext();
//CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColororangeColor] setFill];
//
//    [[selfplaceholder] drawInRect:rectwithFont:[UIFontsystemFontOfSize:20]];
//}

@end
