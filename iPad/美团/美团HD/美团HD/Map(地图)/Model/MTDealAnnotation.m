//
//  MTDealAnnotation.m
//  美团HD
//
//  Created by clm on 15/9/3.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTDealAnnotation.h"


@implementation MTDealAnnotation
- (BOOL)isEqual:(MTDealAnnotation *)other
{
    return [self.title isEqual:other.title];
}
@end
