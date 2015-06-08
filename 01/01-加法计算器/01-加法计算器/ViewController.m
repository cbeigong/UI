//
//  ViewController.m
//  01-加法计算器
//
//  Created by clm on 15/6/8.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)compute
{
    NSString *number1 = self.num1.text;
    NSString *number2 = self.num2.text;
    
    int sum = number1.intValue + number2.intValue;
    self.numberResult.text = [NSString stringWithFormat:@"%d",sum];
    [self.view endEditing:YES];
                        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
