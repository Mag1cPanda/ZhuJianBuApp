//
//  LRTextField.h
//  CZT_IOS_Longrise
//
//  Created by Mag1cPanda on 16/5/19.
//  Copyright © 2016年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LRTextField : UITextField
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, copy) NSString *iconName;
@end
