//
//  MTCategoryViewController.m
//  美团HD
//
//  Created by clm on 15/8/18.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTCategoryViewController.h"
#import "MTHomeDropdown.h"
#import "UIView+Extension.h"
#import "MJExtension.h"
#import "MTCategory.h"

@interface MTCategoryViewController ()

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTHomeDropdown *dropdown = [MTHomeDropdown dropdown];
    
//    dropdown.autoresizingMask = UIViewAutoresizingNone;
    
    // 加载分类数据
    dropdown.categories = [MTCategory objectArrayWithFilename:@"categories.plist"];
    [self.view addSubview:dropdown];
    
    // 设置控制权在popover中的尺寸，让他的尺寸和dropdown一样大
    self.preferredContentSize = dropdown.size;
    
        
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
