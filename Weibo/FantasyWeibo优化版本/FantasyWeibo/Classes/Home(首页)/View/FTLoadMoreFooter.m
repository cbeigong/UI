//
//  FTLoadMoreFooter.m
//  FantasyWeibo
//
//  Created by clm on 15/8/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FTLoadMoreFooter.h"

@implementation FTLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FTLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
