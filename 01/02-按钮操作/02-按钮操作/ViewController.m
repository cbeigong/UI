//
//  ViewController.m
//  02-按钮操作
//
//  Created by clm on 15/6/8.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "ViewController.h"
enum {
    kMoveup = 10,
    kMoveDown,
    kMoveLeft,
    kMoveRight,
} kMoveDir;

#define kMoveDelta 20.0f;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)move:(UIButton *)button
{
    // 1:将图片的frame取出来；其中frame时一个结构体
    CGRect frame = self.iconButton.frame;
    switch (button.tag)
    {
        case kMoveup:
            frame.origin.y -= kMoveDelta;
            break;
        case kMoveDown:
            frame.origin.y += kMoveDelta;
            break;
        case kMoveLeft:
            frame.origin.x -= kMoveDelta;
            break;
        case kMoveRight:
            frame.origin.x += kMoveDelta;
            break;
    }
    // 为对象的属性重新赋值；
    self.iconButton.frame = frame;
}



@end
