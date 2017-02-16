//
//  ZJInputView.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ZJInputView.h"
#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height

@implementation ZJInputView

#pragma mark - Xib初始化
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - 代码初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    
    _leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 9, 80, 40)];
    _leftLab.textColor = DarkTextColor;
    _leftLab.font = ZJFont(13);
    
    _field = [[UITextField alloc] initWithFrame:CGRectMake(90, 9, ViewWidth-90, 40)];
    _field.font = ZJFont(13);
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight-1, ViewWidth, 1)];
    _bottomLine.backgroundColor = RGB(231, 231, 231);
    
    [self addSubview:self.field];
    [self addSubview:self.bottomLine];
    [self addSubview:self.leftLab];
}

#pragma mark - Lazy
//-(UITextField *)field
//{
//    if (!_field) {
//        _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-1)];
//        _field.font = [UIFont systemFontOfSize:13];
//    }
//    return _field;
//}

//-(UIImageView *)imageView
//{
//    if (!_imageView) {
//        CGFloat imgWidth = ViewHeight-1;
//        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgWidth)];
//        _imageView.backgroundColor = [UIColor whiteColor];
//    }
//    return  _imageView;
//}

//-(UILabel *)leftLab
//{
//    if (!_leftLab) {
//        _leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
//        _leftLab.textColor = [UIColor darkGrayColor];
//        _leftLab.font = [UIFont systemFontOfSize:13];
//    }
//    return _leftLab;
//}
//
//-(UIView *)bottomLine
//{
//    if (!_bottomLine) {
//        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight-1, ViewWidth, 1)];
//        _bottomLine.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _field;
//}

#pragma mark - setter
-(void)setLineColor:(UIColor *)lineColor
{
    _bottomLine.backgroundColor = lineColor;
}

-(void)setText:(NSString *)text
{
    _field.text = text;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _field.placeholder = placeholder;
}

//-(void)setLeftImage:(UIImage *)leftImage
//{
//    _imageView.image = leftImage;
//}

-(void)setTitle:(NSString *)title
{
    _leftLab.text = title;
}

-(void)setTextColor:(UIColor *)textColor
{
    _field.textColor = textColor;
}

-(void)setTextAlignment:(NSTextAlignment)textAlignment
{
    _field.textAlignment = textAlignment;
}
@end
