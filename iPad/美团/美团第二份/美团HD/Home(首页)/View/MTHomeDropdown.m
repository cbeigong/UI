//
//  MTHomeDropdown.m
//  美团HD
//
//  Created by clm on 15/8/17.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTHomeDropdown.h"
#import "MTCategory.h"
#import "MTHomeDropdownMainCell.h"
#import "MTHomeDropdownSubCell.h"

@interface MTHomeDropdown () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;

/** 存储被选中的cell中从表的数据 */
@property (nonatomic, assign) NSInteger selectedMainRow;
@end

@implementation MTHomeDropdown

+ (instancetype)dropdown
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTHomeDropdown" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}



#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        // 数据源头 利用数据源调用数据源的方法
        return  [self.dataSource numberOfRowsInMainTable:self];
    } else{
        // 利用数据源，调用数据源的后面的方法
        return [self.dataSource homeDropdown:self subdataForRowInMainTable:self.selectedMainRow].count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        // 注意这个cell的初始化
        cell= [MTHomeDropdownMainCell cellWithTableView:tableView];
        
        // 取出模型数据
        cell.textLabel.text = [self.dataSource homeDropdown:self titleForRowInMainTable:indexPath.row];
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:iconForRowInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self iconForRowInMainTable:indexPath.row]];
        }
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:selectedIconForRowInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self selectedIconForRowInMainTable:indexPath.row]];
        }
        
        // 看每个cell是否需要箭头
        NSArray *subdata = [self.dataSource homeDropdown:self subdataForRowInMainTable:indexPath.row];
        if (subdata.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
//
//        MTCategory *categoriy = self.categories[indexPath.row];
//        cell.textLabel.text = categoriy.name;
//        cell.imageView.image = [UIImage imageNamed:categoriy.small_icon];
//        if (categoriy.subcategories.count) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        } else {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//
    } else{ // 从表 设置背景色什么的
        cell = [MTHomeDropdownSubCell cellWithTableView:tableView];
        
        NSArray *subdata = [self.dataSource homeDropdown:self subdataForRowInMainTable:self.selectedMainRow];
        
        cell.textLabel.text = subdata[indexPath.row];
    }

    return cell;
}


// 如果在主表中选中的话， 那么刷新从表
#pragma 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == self.mainTableView) {
//        // 被点击打分类
//        self.selectedCategory = self.categories[indexPath.row];
//        // 刷新右边的数据
//        [self.subTableView reloadData];
//    }
    if (tableView == self.mainTableView) {
        // 被点击的数据
        self.selectedMainRow = indexPath.row;
        // 刷新右边的数据
        [self.subTableView reloadData];
        
        // 通知代理 让代理做一些事情
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInMainTable:indexPath.row];
        }
    } else {
        // 通知代理
        if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInSubTable:inMainTable:)]) {
            [self.delegate homeDropdown:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
        }
    }
}



@end
