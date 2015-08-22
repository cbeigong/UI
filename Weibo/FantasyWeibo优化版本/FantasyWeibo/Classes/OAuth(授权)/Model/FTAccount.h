//
//  FTAccount.h
//  FantasyWeibo
//
//  Created by clm on 15/7/29.
//  Copyright (c) 2015年 clm. All rights reserved.
//
//  面向模型编程。其实就是把字典中的数据转换成对象中的数据，然后就可以有方法之类编程的时候就很方便。

#import <Foundation/Foundation.h>
/** 遵守协议， 实现decoder和encoder等方法 */
@interface FTAccount : NSObject <NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**	access token的创建时间 */
@property (nonatomic, strong) NSDate *created_time;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/** 用户的昵称 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
