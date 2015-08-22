//
//  HMColorsViewController.h
//  02-Popover的其他的用法
//
//  Created by clm on 15/8/15.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
// 因为要实现，当点击到某一行cell的时候，对应的按钮就会变色。点击某一行cell是HMColorsViewController上所要做的事所以让对应的按钮去监听这个代理方法，首先要在HMColorsViewController上写一个代理方法。

// 声明代理
@class HMColorsViewController;
@protocol HMColorsViewControllerDelegate <NSObject>

@optional
- (void)colorSViewController:(HMColorsViewController *)vc didSelectColor:(UIColor *)color;
@end

@interface HMColorsViewController : UITableViewController
@property (nonatomic, weak) id<HMColorsViewControllerDelegate> delegate;
@end
