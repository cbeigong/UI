//
//  MTDealsViewController.h
//  美团HD
//
//  Created by clm on 15/9/1.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDealsViewController : UICollectionViewController
/**
 *  设置请求参数:交给子类去实现
 */
- (void)setupParams:(NSMutableDictionary *)params;
@end
