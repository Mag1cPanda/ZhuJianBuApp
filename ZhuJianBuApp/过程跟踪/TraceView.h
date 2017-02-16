//
//  TraceView.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/5.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapHandle) (UIView *view);
typedef NS_ENUM(NSInteger, TraceViewStyle) {
    TraceViewStyleLeft = 0,
    TraceViewStyleRight = 1,
};

@interface TraceView : UIView
@property (strong, nonatomic) UIImageView *icon;

@property (strong, nonatomic) UIImageView *dot;

@property (strong, nonatomic) UILabel *timeLab;

@property (strong, nonatomic) UILabel *typeLab;

@property (nonatomic, copy) TapHandle block;

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *dotName;
@property (nonatomic, copy) NSString *type;


- (instancetype)initWithFrame:(CGRect)frame style:(TraceViewStyle)style;
@end
