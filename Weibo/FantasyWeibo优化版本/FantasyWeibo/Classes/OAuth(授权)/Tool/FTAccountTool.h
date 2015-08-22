//
//  FTAccountTool.h
//  FantasyWeibo
//
//  Created by clm on 15/7/30.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FTAccount.h"

@interface FTAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+ (void)saveAccount:(FTAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型（如果账号过期，返回nil）
 */
+ (FTAccount *)account;
@end
