//
//  ViewController.h
//  01-加法计算器
//
//  Created by clm on 15/6/8.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *num1;
@property (weak, nonatomic) IBOutlet UITextField *num2;
@property (weak, nonatomic) IBOutlet UILabel *numberResult;

- (void)compute;
@end

