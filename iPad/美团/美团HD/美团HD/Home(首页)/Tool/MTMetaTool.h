//
//  MTMetaTool.h
//  美团HD
//
//  Created by clm on 15/8/31.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MTCategory, MTDeal;
@interface MTMetaTool : NSObject
+ (NSArray *)cities;

+ (NSArray *)categories;
+ (MTCategory *)categoryWithDeal:(MTDeal *)deal;

+ (NSArray *)sorts;
@end
