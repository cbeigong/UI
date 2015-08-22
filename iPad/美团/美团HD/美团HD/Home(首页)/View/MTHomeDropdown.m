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
@property (nonatomic, strong) MTCategory *selectedCategory;

@end

@implementation MTHomeDropdown

+ (instancetype)dropdown
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTHomeDropdown" owner:nil options:nil] firstObject];
}



#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return self.categories.count;
    } else{
        // 每个模型他还有子模型的东西
        return self.selectedCategory.subcategories.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        // 注意这个cell的初始化
        cell= [MTHomeDropdownMainCell cellWithTableView:tableView];
        
        MTCategory *categoriy = self.categories[indexPath.row];
        cell.textLabel.text = categoriy.name;
        cell.imageView.image = [UIImage imageNamed:categoriy.small_icon];
        if (categoriy.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else{ // 从表
        cell = [MTHomeDropdownSubCell cellWithTableView:tableView];
        
        cell.textLabel.text = self.selectedCategory.subcategories[indexPath.row];
    }

    return cell;
}


// 如果在主表中选中的话， 那么刷新从表
#pragma 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        // 被点击打分类
        self.selectedCategory = self.categories[indexPath.row];
        // 刷新右边的数据
        [self.subTableView reloadData];
    }
}



@end
