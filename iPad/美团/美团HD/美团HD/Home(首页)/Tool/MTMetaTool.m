//
//  MTMetaTool.m
//  美团HD
//
//  Created by clm on 15/8/31.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTMetaTool.h"
#import "MTCity.h"
#import "MTCategory.h"
#import "MTSort.h"
#import "MJExtension.h"


@implementation MTMetaTool
static NSArray *_cities;
+ (NSArray *)cities
{
    if (_cities == nil) {
        _cities = [MTCity objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

static NSArray *_categories;
+ (NSArray *)categories
{
    if (_categories == nil) {
        _categories = [MTCategory objectArrayWithFilename:@"categories.plist"];;
    }
    return _categories;
}

static NSArray *_sorts;
+ (NSArray *)sorts
{
    if (_sorts == nil) {
        _sorts = [MTSort objectArrayWithFilename:@"sorts.plist"];;
    }
    return _sorts;
}


@end
