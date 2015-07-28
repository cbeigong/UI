//
//  FTDropdownMenu.h
//  FantasyWeibo
//
//  Created by clm on 15/7/24.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
// 此@class 就是生命FTDropdownMenuDelegate是存在的
@class FTDropdownMenu;

@protocol FTDropdownMenuDelegate <NSObject>

- (void)dropdownMenuDidDismiss:(FTDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(FTDropdownMenu *)munu;


@end
@interface FTDropdownMenu : UIView

@property (nonatomic, weak) id<FTDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;
/**
 *  销毁
 */
- (void)dismiss;

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;
/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

@end
