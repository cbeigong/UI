//
//  MTRegionViewController.h
//  美团HD
//
//  Created by clm on 15/9/1.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTRegionViewController : UIViewController
// 在MTHomeViewController 把数据传到这里
@property (nonatomic, strong) NSArray *regions;
@property (nonatomic, weak) UIPopoverController *popover;
@end
