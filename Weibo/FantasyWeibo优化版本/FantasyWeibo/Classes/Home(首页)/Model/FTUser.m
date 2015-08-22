//
//  FTUser.m
//  FantasyWeibo
//
//  Created by clm on 15/8/5.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "FTUser.h"

@implementation FTUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//- (BOOL)isVip
//{
//    return self.mbrank > 2;
//}
@end
