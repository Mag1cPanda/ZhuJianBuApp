//
//  RegBtn.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/15.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "RegBtn.h"

@implementation RegBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{

    return CGRectMake(10, self.height/2-10, 20, 20);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(40, self.height/2-10, self.width-40, 20);
}

@end
