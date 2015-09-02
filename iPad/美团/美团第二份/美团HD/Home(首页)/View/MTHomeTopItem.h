//
//  MTHomeTopItem.h
//  美团HD
//
//  Created by clm on 15/8/17.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeTopItem : UIView
+ (instancetype)item;

- (void)addTarget:(id)target action:(SEL)action;


- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)setIcon:(NSString *)icon highIcon:(NSString *)highIcon;
@end
