//
//  MTSort.h
//  美团HD
//
//  Created by clm on 15/8/31.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSort : NSObject
/** 排序名称 */
@property (nonatomic, copy) NSString *label;
/** 排序的值(将来发给服务器) */
@property (nonatomic, assign) int value;
@end
