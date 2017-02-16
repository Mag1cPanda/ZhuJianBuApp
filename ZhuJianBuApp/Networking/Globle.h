//
//  Globle.h
//  TBRJL
//
//  Created by 程三 on 15/6/13.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Globle : NSObject

//升级平台地址
@property(nonatomic,copy)NSString *updateURL;
//登陆对象
@property(nonatomic,retain)NSDictionary *loginData;
//经度
@property(nonatomic,assign)float imagelon;
//纬度
@property(nonatomic,assign)float imagelat;
//事故地址
@property(nonatomic,copy) NSString *imageaddress;
//外层的用户名和密码，该值时不变的
@property(nonatomic,copy) NSString *loadDataName;
@property(nonatomic,copy) NSString *loadDataPass;

@property(nonatomic,copy)NSString *token;

@property (nonatomic, copy) NSString *APP_Version;
@property (nonatomic, copy) NSString *JS_Version;

+(Globle *)getInstance;

@end
