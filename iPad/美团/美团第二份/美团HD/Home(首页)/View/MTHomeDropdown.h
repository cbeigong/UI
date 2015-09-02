//
//  MTHomeDropdown.h
//  美团HD
//
//  Created by clm on 15/8/17.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>

// 数据源， 数据方法
@class MTHomeDropdown;

@protocol MTHomeDropdownDataSource <NSObject>
/**
 *  左边表格一共有多少行
 */
- (NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown;
/**
 *  左边表格每一行的标题
 *  @param row          行号
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row;
/**
 *  左边表格每一行的子数据
 *  @param row          行号
 */
- (NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row;

@optional
/**
 *  左边表格每一行的图标
 *  @param row          行号
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown iconForRowInMainTable:(int)row;
/**
 *  左边表格每一行的选中图标
 *  @param row          行号
 */
- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(int)row;
@end

// 代理方法
@protocol MTHomeDropdownDelegate <NSObject>

@optional
- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInMainTable:(int)row;
- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInSubTable:(int)subrow inMainTable:(int)mainRow;
@end


@interface MTHomeDropdown : UIView
+ (instancetype)dropdown;
// 声明数据源和代理方法，让别人去遵守。
@property (nonatomic, weak) id<MTHomeDropdownDataSource> dataSource;
@property (nonatomic, weak) id<MTHomeDropdownDelegate> delegate;
@end


