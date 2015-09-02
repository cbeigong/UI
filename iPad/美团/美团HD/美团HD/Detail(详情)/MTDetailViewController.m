//
//  MTDetailViewController.m
//  美团HD
//
//  Created by clm on 15/9/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTDetailViewController.h"

@interface MTDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)back;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
- (IBAction)buy;
- (IBAction)collect;
- (IBAction)share;
@property (weak, nonatomic) IBOutlet UIButton *refundableAnyTimeButton;
@property (weak, nonatomic) IBOutlet UIButton *refundableExpireButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *leftTimeButton;

@end

@implementation MTDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back {
}
- (IBAction)buy {
}

- (IBAction)collect {
}

- (IBAction)share {
}
@end
