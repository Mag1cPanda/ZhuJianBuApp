//
//  BaseViewController.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBackBtn.h"

@interface BaseViewController : UIViewController
@property (nonatomic, strong) BaseBackBtn *backBtn;
-(void)backAction;
@end
