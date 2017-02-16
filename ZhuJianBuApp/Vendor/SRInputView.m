//
//  SRInputView.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "SRInputView.h"
#define ViewWidth self.frame.size.width
#define ViewHeight self.frame.size.height

@implementation SRInputView

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

- (instancetype)initWithFrame:(CGRect)frame style:(SRInputViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.field];
    [self addSubview:self.bottomLine];
}

#pragma mark - Lazy
-(UITextField *)field
{
    if (!_field) {
        _field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewHeight-1)];
        _field.leftView = self.imageView;
    }
    return _field;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        CGFloat imgWidth = ViewHeight-1;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgWidth)];
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return  _imageView;
}

-(UIView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight-1, ViewWidth, 1)];
        //default is whiteColor
        _bottomLine.backgroundColor = [UIColor whiteColor];
    }
    return _field;
}

#pragma mark - setter
-(void)setLineColor:(UIColor *)lineColor
{
    _bottomLine.backgroundColor = lineColor;
}

-(void)setText:(NSString *)text
{
    _field.text = text;
}

-(void)setPlaceHolder:(NSString *)placeHolder
{
    _field.placeholder = placeHolder;
}

-(void)setLeftImage:(UIImage *)leftImage
{
    _imageView.image = leftImage;
}

@end
