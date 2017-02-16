//
//  TraceView.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/5.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "TraceView.h"

@implementation TraceView

- (instancetype)initWithFrame:(CGRect)frame style:(TraceViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTaped)];
        [self addGestureRecognizer:tap];
        
        UIView *dashLine = [[UIView alloc] initWithFrame:CGRectMake(self.width/2-50, self.height/2, 100, 1)];
        [self drawDashLine:dashLine lineLength:100 lineSpacing:10 lineColor:RGB(234, 234, 236)];
        [self addSubview:dashLine];
        
        UIView *fullLine = [[UIView alloc] initWithFrame:CGRectMake(self.width/2, 0, 1, self.height)];
        fullLine.backgroundColor = RGB(219, 219, 219);
        [self addSubview:fullLine];
        
        _dot = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-10, self.height/2-10, 20, 20)];
        _dot.image = [UIImage imageNamed:@"dot_blue"];
        [self addSubview:_dot];
        [self bringSubviewToFront:_dot];
        
        //图片在左
        if (style == TraceViewStyleLeft) {
            _icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-130, self.height/2-40, 80, 80)];
            _icon.image = [UIImage imageNamed:@"trace_icon01"];
            [self addSubview:_icon];
            //        [self bringSubviewToFront:_icon];
            
            _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+50, self.height/2-30, 110, 30)];
            _timeLab.font = ZJFont(20);
            _timeLab.text = @"2017.01.02";
            [self addSubview:_timeLab];
            
            _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2+50, self.height/2, 100, 20)];
            _typeLab.font = ZJFont(18);
            _typeLab.text = @"个人申请";
            _typeLab.textColor = [UIColor grayColor];
            [self addSubview:_typeLab];
        }
        
        //图片在右
        else {
            _icon = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2+50, self.height/2-40, 80, 80)];
            _icon.image = [UIImage imageNamed:@"trace_icon01"];
            [self addSubview:_icon];
            //        [self bringSubviewToFront:_icon];
            
            _timeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-150, self.height/2-30, 110, 30)];
            _timeLab.font = ZJFont(20);
            _timeLab.text = @"2017.01.02";
            [self addSubview:_timeLab];
            
            _typeLab = [[UILabel alloc] initWithFrame:CGRectMake(self.width/2-150, self.height/2, 100, 20)];
            _typeLab.font = ZJFont(18);
            _typeLab.text = @"个人申请";
            _typeLab.textColor = [UIColor grayColor];
            [self addSubview:_typeLab];
        }
        
    }
    
    return self;
}

    
-(void)viewTaped
{
    if (_block) {
        _block(self);
    }
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

#pragma mark - setter

-(void)setTime:(NSString *)time
{
    _time = time;
    _timeLab.text = time;
}

-(void)setType:(NSString *)type
{
    _type = type;
    _typeLab.text = type;
}

-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    _icon.image = [UIImage imageNamed:imageName];
}

-(void)setDotName:(NSString *)dotName
{
    _dotName = dotName;
    _dot.image = [UIImage imageNamed:dotName];
}

@end
