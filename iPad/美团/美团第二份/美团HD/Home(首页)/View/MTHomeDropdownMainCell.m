//
//  MTHomeDropdownMainCell.m
//  美团HD
//
//  Created by clm on 15/8/20.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTHomeDropdownMainCell.h"

@implementation MTHomeDropdownMainCell

//- (void)awakeFromNib {
//    // Initialization code
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}


#pragma mark - cell 初始化
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"Main";
    MTHomeDropdownMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MTHomeDropdownMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //    UIImage 是图片，不是控件；他的父类为NSObject;
        //    UIImageView是加载图片的控件，父类为UIView  所以下面应该用UIImageView而不是UIImage
        //    UIImage *bg = [[UIImage alloc] init];
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView = selectedBg;
    }
    return self;
    // 一般如果是instancetype的黄瓜，都是把自己返回来的。

}
@end
