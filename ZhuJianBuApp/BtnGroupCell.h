//
//  BtnGroupCell.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/4.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJButton.h"
@class BtnGroupCell;

@protocol BtnGroupCellDelegate <NSObject>

@optional;

/**
 BtnGroupCellDelegate

 @param btnGroup btnGroup
 @param index 0~6  分别对应7个按钮
 */
-(void)btnGroup:(BtnGroupCell *)btnGroup didSelectItemAtIndex:(NSInteger)index;

@end

@interface BtnGroupCell : UITableViewCell
@property (nonatomic, strong) ZJButton *zcsbBtn;
@property (nonatomic, strong) ZJButton *gcgzBtn;
@property (nonatomic, strong) ZJButton *zscxBtn;
@property (nonatomic, strong) ZJButton *jxjyBtn;
@property (nonatomic, strong) ZJButton *zxksBtn;
@property (nonatomic, strong) ZJButton *hgzmBtn;
@property (nonatomic, strong) ZJButton *grxxBtn;

@property (nonatomic, weak) id<BtnGroupCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
