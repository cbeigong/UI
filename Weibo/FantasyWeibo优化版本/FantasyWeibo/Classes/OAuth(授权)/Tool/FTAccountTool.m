//
//  FTAccountTool.m
//  FantasyWeibo
//
//  Created by clm on 15/7/30.
//  Copyright (c) 2015年 clm. All rights reserved.
//  处理账号相关的所有操作:存储账号、取出账号、验证账号

// 账号的存储路径
#define FTAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]


#import "FTAccountTool.h"
#import "FTAccount.h"

@implementation FTAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(FTAccount *)account
{
//    // 获得账号存储的时间（accessToken的产生时间）
//    account.created_time = [NSDate date];
//    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:FTAccountPath];
}


/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (FTAccount *)account
{
    // 加载模型
    FTAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:FTAccountPath];
    
    /* 验证账号是否过期 */
    
    // 过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    // 获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 获得当前时间
    NSDate *now = [NSDate date];
    
    // 如果expiresTime <= now，过期
    /**
     NSOrderedAscending = -1L, 升序，右边 > 左边
     NSOrderedSame, 一样
     NSOrderedDescending 降序，右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { // 过期
        return nil;
    }
    
    return account;
}


@end
