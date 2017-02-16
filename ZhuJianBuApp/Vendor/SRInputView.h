//
//  SRInputView.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/3.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SRInputViewStyle) {
   SRInputViewStyleRoundRect,
    SRInputViewStyleBottomLine
};

@interface SRInputView : UIView
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) NSString *text;

- (instancetype)initWithFrame:(CGRect)frame style:(SRInputViewStyle)style;
@end
