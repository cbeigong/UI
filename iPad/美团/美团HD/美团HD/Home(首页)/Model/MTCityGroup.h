//
//  MTCityGroup.h
//  美团HD
//
//  Created by clm on 15/8/21.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroup : NSObject
/** 这组的所有城市 */
@property (nonatomic, strong) NSArray *cities;

/** 这字母组的标题 */
@property (nonatomic, copy) NSString *title;

@end
