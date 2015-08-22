//
//  ViewController.m
//  03-modal
//
//  Created by clm on 15/8/15.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    SecondViewController *vc = [[SecondViewController alloc] init];
    
    vc.view.backgroundColor = [UIColor redColor];
    
    //
    //    UIModalPresentationFullScreen = 0,
    //    UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2),
    //    UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2),
    //
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    //    UIModalTransitionStyleCoverVertical = 0,
    //    UIModalTransitionStyleFlipHorizontal,
    //    UIModalTransitionStyleCrossDissolve,
    //    UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2),
    
    
    self.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:vc animated:YES completion:nil];
    
}


@end
