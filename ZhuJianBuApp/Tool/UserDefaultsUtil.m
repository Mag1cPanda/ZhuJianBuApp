//
//  UserDefaultsUtil.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/8.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "UserDefaultsUtil.h"

#define LRUserDefaults [NSUserDefaults standardUserDefaults]

@implementation UserDefaultsUtil

+(void)saveNSUserDefaultsForInteger:(NSInteger)value forKey:(NSString *)key
{
    [LRUserDefaults setInteger:value forKey:key];
    [LRUserDefaults synchronize];
}
 
+(void)saveNSUserDefaultsForFloat:(float)value forKey:(NSString *)key
{
    [LRUserDefaults setFloat:value forKey:key];
    [LRUserDefaults synchronize];
}

+(void)saveNSUserDefaultsForDouble:(double)value forKey:(NSString *)key
{
    [LRUserDefaults setDouble:value forKey:key];
    [LRUserDefaults synchronize];
}

+(void)saveNSUserDefaultsForBOOL:(BOOL)value forKey:(NSString *)key
{
    [LRUserDefaults setBool:value forKey:key];
    [LRUserDefaults synchronize];
}

+(void)saveNSUserDefaultsForObject:(id)value forKey:(NSString *)key
{
    [LRUserDefaults setObject:value forKey:key];
    [LRUserDefaults synchronize];
}

+(id)getDataForKey:(NSString *)key
{
    return  [LRUserDefaults objectForKey:key];
}

+(void)removeDataForKey:(NSString *)key
{
    [LRUserDefaults removeObjectForKey:key];
    [LRUserDefaults synchronize];
}

+(void)removeAllUserDefaults{
    NSDictionary *userDic = [LRUserDefaults dictionaryRepresentation];
    for (NSString *key in [userDic allKeys]) {
        [LRUserDefaults removeObjectForKey:key];
    }
    [LRUserDefaults synchronize];
}
@end
