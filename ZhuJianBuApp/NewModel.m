//
//  NewModel.m
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/8.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "NewModel.h"

@implementation NewModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
