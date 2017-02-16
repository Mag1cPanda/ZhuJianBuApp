//
//  ZJButton.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "ZJButton.h"
#define imageWidth self.frame.size.width/2
#define Scale ScreenWidth/375

@implementation ZJButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.zj_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2-imageWidth/2, self.height/2-imageWidth/2-10*Scale, imageWidth, imageWidth)];
        [self addSubview:self.zj_ImageView];
        
        self.zj_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.zj_ImageView.maxY+5, self.width, 20*Scale)];
        self.zj_titleLabel.font = ZJFont(13);
        self.zj_titleLabel.textAlignment = NSTextAlignmentCenter;
        self.zj_titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:self.zj_titleLabel];
        
        self.layer.borderColor = RGB(238, 238, 240).CGColor;
        self.layer.borderWidth = 0.5;
        
//        UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//        self.imageEdgeInsets = UIEdgeInsetsMake(-(self.height-self.imageView.height), 0, 0, -self.titleLabel.width);
//        self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.width, -(self.height-self.titleLabel.height), 0);
    }
    return self;
}

-(void)setZj_Text:(NSString *)zj_Text
{
    self.zj_titleLabel.text = zj_Text;
}

-(void)setZj_Image:(UIImage *)zj_Image
{
    self.zj_ImageView.image = zj_Image;
}

//-(CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    
//    return CGRectMake(ViewCenterX-imageWidth/2, ViewCenterY-imageWidth/2-20, imageWidth, imageWidth);
//}
//
////ViewCenterY+imageWidth/2+10-20
//-(CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(ViewCenterX-imageWidth/2, self.imageView.maxY+10, imageWidth, 20);
//}


@end
