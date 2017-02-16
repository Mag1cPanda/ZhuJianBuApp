//
//  ZJButton.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJButton : UIButton
@property (nonatomic, strong) UIImageView *zj_ImageView;
@property (nonatomic, strong) UILabel *zj_titleLabel;

@property (nonatomic, strong) UIImage *zj_Image;
@property (nonatomic, copy) NSString *zj_Text;
@end
