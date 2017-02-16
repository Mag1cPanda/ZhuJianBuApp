//
//  NewModel.h
//  ZhuJianBuApp
//
//  Created by Mag1cPanda on 2017/2/8.
//  Copyright © 2017年 Mag1cPanda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
