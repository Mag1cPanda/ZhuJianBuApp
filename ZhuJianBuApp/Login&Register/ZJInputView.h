//
//  ZJInputView.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJInputView : UIView

@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UIView *bottomLine;
//@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *leftLab;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
