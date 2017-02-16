//
//  ModifyViewController.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/10.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import "BaseViewController.h"

typedef void (^ModifySuccess)(NSString *info);

@interface ModifyViewController : BaseViewController
@property (nonatomic, copy) NSString *oldText;

@property (nonatomic, copy) ModifySuccess block;
@end
