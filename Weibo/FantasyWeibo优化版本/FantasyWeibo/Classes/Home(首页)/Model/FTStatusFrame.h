//
//  FTStatusFrame.h
//  FantasyWeibo
//
//  Created by clm on 15/8/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//  一个HWStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HWStatus
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 昵称字体
#define FTStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define FTStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define FTStatusCellSourceFont FTStatusCellTimeFont
// 正文字体
#define FTStatusCellContentFont [UIFont systemFontOfSize:14]

@class FTStatus;

@interface FTStatusFrame : NSObject

@property (nonatomic, strong) FTStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;


@end
