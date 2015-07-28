//
//  FTTabBar.h
//  FantasyWeibo
//
//  Created by clm on 15/7/26.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FTTabBar;

#warning 因为FTTaBbar继承自UITabBar，所以称为FTTabBar的代理，也必须实现UITabBar的代理协议
@protocol FTTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(FTTabBar *)tabBar;
@end


@interface FTTabBar : UITabBar
@property (nonatomic, weak) id<FTTabBarDelegate> delegate;

@end
