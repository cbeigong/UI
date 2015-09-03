//
//  MTDetailViewController.h
//  美团HD
//
//  Created by clm on 15/9/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal;
// 此处的模型数据都是通过跟服务器交互获得的
@interface MTDetailViewController : UIViewController
@property (nonatomic, strong) MTDeal *deal;
@end
