//
//  MTCategoryViewController.m
//  美团HD
//
//  Created by clm on 15/8/18.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTCategoryViewController.h"
#import "MTHomeDropdown.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "MTCategory.h"
#import "MTConst.h"
#import "MTMetaTool.h"
@interface MTCategoryViewController () <MTHomeDropdownDataSource, MTHomeDropdownDelegate>

@end

@implementation MTCategoryViewController

- (void)loadView
{
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    dropdown.dataSource = self;
    dropdown.delegate = self;
    
    self.view = dropdown;
     // 设置控制权在popover中的尺寸，让他的尺寸和dropdown一样大
    self.preferredContentSize = dropdown.size;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    
//    dropdown.autoresizingMask = UIViewAutoresizingNone;
    
//    // 加载分类数据
//    dropdown.categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
//    [self.view addSubview:dropdown];
//    
//    // 设置控制权在popover中的尺寸，让他的尺寸和dropdown一样大
//    self.preferredContentSize = dropdown.size;

//    
    
}

#pragma mark - MTHomeDropdownDataSource
- (NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown
{
    return [MTMetaTool categories].count;
}

- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row
{
    MTCategory *category = [MTMetaTool categories][row];
    return category.name;
}

- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown iconForRowInMainTable:(int)row
{
    MTCategory *category = [MTMetaTool categories][row];
    return category.small_icon;
}

- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown selectedIconForRowInMainTable:(int)row
{
    MTCategory *category = [MTMetaTool categories][row];
    return category.small_highlighted_icon;
}

- (NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row
{
    MTCategory *category = [MTMetaTool categories][row];
    return category.subcategories;
}

#pragma mark - MTHomeDropdownDelegate
- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInMainTable:(int)row
{
    MTCategory *category = [MTMetaTool categories][row];
    if (category.subcategories.count == 0) {
        [MTNotificationCenter postNotificationName:MTCategoryDidChangeNotification object:nil userInfo:@{MTSelectCategory : category}];
    }
}

- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInSubTable:(int)subrow inMainTable:(int)mainRow
{
    MTCategory *category = [MTMetaTool categories][mainRow];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCategoryDidChangeNotification object:nil userInfo:@{MTSelectCategory : category, MTSelectSubcategoryName : category.subcategories[subrow]}];
}
@end
