//
//  MTCategory.h
//  美团HD
//
//  Created by clm on 15/8/18.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCategory : NSObject
/** 类别的名称 */
@property (nonatomic, copy) NSString *name;
/** 显示在导航栏顶部的大图标 */
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *highlighted_icon;

/** 显示在地图上的图标 */
@property (nonatomic, copy) NSString *map_icon;

/** 显示在下拉菜单大小图标 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
@property (nonatomic, copy) NSString *small_icon;

/** 子类别:里面都是字符串：里面存放的是子类别的名称 */
@property (nonatomic, strong) NSArray *subcategories;

@end
