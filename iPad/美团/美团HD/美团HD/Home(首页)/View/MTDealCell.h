//
//  MTDealCell.h
//  美团HD
//
//  Created by clm on 15/9/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MTDeal, MTDealCell;


@protocol MTDealCellDelegate <NSObject>

@optional
- (void)dealCellCheckingStateDidChange:(MTDealCell *)cell;

@end

@interface MTDealCell : UICollectionViewCell
@property (nonatomic, strong) MTDeal *deal;
@property (nonatomic, weak) id<MTDealCellDelegate> delegate;

@end
