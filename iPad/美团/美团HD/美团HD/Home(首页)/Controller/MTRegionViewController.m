//
//  MTRegionViewController.m
//  美团HD
//
//  Created by clm on 15/9/1.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTRegionViewController.h"
#import "MTHomeDropdown.h"
#import "UIView+Extension.h"
#import "MTCityViewController.h"
#import "MTNavigationController.h"
#import "MTRegion.h"
#import "MTConst.h"


@interface MTRegionViewController () <MTHomeDropdownDataSource, MTHomeDropdownDelegate>
- (IBAction)changeCity;
@end

@implementation MTRegionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建下拉菜单
    UIView *title = [self.view.subviews firstObject];
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    dropdown.y = title.height;
    dropdown.dataSource = self;
    dropdown.delegate = self;
    [self.view addSubview:dropdown];
    
    // 设置控制器在popover中的尺寸
    self.preferredContentSize = CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
 
//    NSLog(@"%@",dropdown);
    
    
    
    
    
    
//    // 因为UIViewController中只有一个UIView所以用的是firstObject
//    UIView *titleBar = [self.view.subviews firstObject];
//    
//    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
////    dropdown.backgroundColor = [UIColor redColor];
//    
//    
//    
//    // 因为是要添加到UIView上面去的。
//    dropdown.y = titleBar.height;
//    dropdown.dataSource = self;
//    dropdown.delegate = self;
//    
//    // 添加dropdown控件
//    [self.view addSubview:dropdown];
////
//    
//    
//    
//    
////    // 下面的这行代码就是让popover出来的东西的大小等于下拉菜单的大小。
////    self.preferredContentSize = dropdown.size;//CGSizeMake(dropdown.width,
//    // 设置控制器在popover中的尺寸
//    self.preferredContentSize = CGSizeMake(dropdown.width, CGRectGetMaxY(dropdown.frame));
//
}





- (IBAction)changeCity {
#warning 此处为什么没有 dismiss下去?
    [self.popover dismissPopoverAnimated:YES];
    
    MTCityViewController *city = [[MTCityViewController alloc] init];
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:city];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // 利用后面的根控制器去modal出来新的控制器
//    [self presentViewController:nav animated:YES completion:nil];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    // self.presentedViewController会引用着被modal出来的控制器
    // modal出来的是MTNavigationController
    // dismiss掉的应该也是MTNavigationController
}
#pragma - MTHomeDropdownDataSource
- (NSInteger)numberOfRowsInMainTable:(MTHomeDropdown *)homeDropdown
{
    return self.regions.count;
}

- (NSString *)homeDropdown:(MTHomeDropdown *)homeDropdown titleForRowInMainTable:(int)row
{
    MTRegion *region = self.regions[row];
    return region.name;
}

- (NSArray *)homeDropdown:(MTHomeDropdown *)homeDropdown subdataForRowInMainTable:(int)row
{
    MTRegion *region = self.regions[row];
    return region.subregions;
}

#pragma mark - MTHomeDropdownDelegate
- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInMainTable:(int)row
{
    MTRegion *region = self.regions[row];
    if(region.subregions.count == 0)
    {
        // 把region这个模型发出去
        [MTNotificationCenter postNotificationName:MTRegionDidChangeNotification object:nil userInfo:@{MTSelectRegion : region}];
    }
}

- (void)homeDropdown:(MTHomeDropdown *)homeDropdown didSelectRowInSubTable:(int)subrow inMainTable:(int)mainRow
{
    MTRegion *region = self.regions[mainRow];
    // 发出通知
    [MTNotificationCenter postNotificationName:MTRegionDidChangeNotification object:nil userInfo:@{MTSelectRegion : region, MTSelectSubcategoryName : region.subregions[subrow]}];
}

@end
