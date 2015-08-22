//
//  FTStatusCell.h
//  FantasyWeibo
//
//  Created by clm on 15/8/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTStatusFrame;

@interface FTStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (nonatomic, strong) FTStatusFrame *statusFrame;


@end
