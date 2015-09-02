//
//  MTRegion.h
//  美团HD
//
//  Created by clm on 15/8/31.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRegion : NSObject
/** 区域名字 */
@property (nonatomic, copy) NSString *name;
/** 子区域 */
@property (nonatomic, strong) NSArray *subregions;
@end
