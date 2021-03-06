//
//  MTDetailViewController.m
//  美团HD
//
//  Created by clm on 15/9/2.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTDetailViewController.h"
#import "MTConst.h"
#import "MTDeal.h"
#import "DPAPI.h"
#import "MjEXtension.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "MTRestrictions.h"
#import "MTDealTool.h"


@interface MTDetailViewController () <DPRequestDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;
- (IBAction)back;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
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
    self.view.backgroundColor = MTGlobalBg;
    self.titleLabel.text = self.deal.title;
    self.descLabel.text = self.deal.desc;
    self.webView.delegate = self;

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];

    //   等到吧webView截取出来之后再，显示出来
//    self.webView.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.deal.deal_h5_url]]];
    
    // 设置剩余时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *dead = [fmt dateFromString:self.deal.purchase_deadline];
    // 追加1天
    dead = [dead dateByAddingTimeInterval:24 * 60 * 60];
    NSDate *now = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *cmps = [[NSCalendar currentCalendar] components:unit fromDate:now toDate:dead options:0];
    if (cmps.day > 365) {
        [self.leftTimeButton setTitle:@"一年内不过期" forState:UIControlStateNormal];
    } else {
        [self.leftTimeButton setTitle:[NSString stringWithFormat:@"%d天%d小时%d分钟", cmps.day, cmps.hour, cmps.minute] forState:UIControlStateNormal];
    }
    
    // 发送请求获得更详细的团购数据
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 页码
    params[@"deal_id"] = self.deal.deal_id;
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
#warning 每次点开一个详情之后就应该把它进行收藏
    self.collectButton.selected = [MTDealTool isCollected:self.deal];

    
    

    
}


- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)buy {
}

- (IBAction)collect {
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[MTCollectDealKey] = self.deal;
    
    if (self.collectButton.isSelected) { // 取消收藏
        [MTDealTool removeCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"取消收藏成功" toView:self.view];
        
        info[MTIsCollectKey] = @NO;
    } else { // 收藏
        [MTDealTool addCollectDeal:self.deal];
        [MBProgressHUD showSuccess:@"收藏成功" toView:self.view];
        
        info[MTIsCollectKey] = @YES;
    }
    
    // 按钮的选中取反
    self.collectButton.selected = !self.collectButton.isSelected;
    NSLog(@"***********************");
    
    // 发出通知
    [MTNotificationCenter postNotificationName:MTCollectStateDidChangeNotification object:nil userInfo:info];

    
}

- (IBAction)share {
}

#pragma mark - DPRequestDelegate
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    self.deal = [MTDeal objectWithKeyValues:[result[@"deals"] firstObject]];
    
    // 设置退款信息
    self.refundableAnyTimeButton.selected = self.deal.restrictions.is_refundable;
    self.refundableExpireButton.selected = self.deal.restrictions.is_refundable;
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    [MBProgressHUD showError:@"网络繁忙,请稍后再试" toView:self.view];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // 旧的html5加载完毕
    if ([webView.request.URL.absoluteString isEqualToString:self.deal.deal_h5_url]) {
        NSString *ID = [self.deal.deal_id substringFromIndex:[self.deal.deal_id rangeOfString:@"-"].location + 1];
        NSString *urlStr = [NSString stringWithFormat:@"http://lite.m.dianping.com/group/deal/moreinfo/%@", ID];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    } else { // 详情页面加载完毕
        // 用来拼接所有的JS
        
        NSMutableString *js = [NSMutableString string];
        // 删除header
        [js appendString:@"var header = document.getElementsByTagName('header')[0];"];
        [js appendString:@"header.parentNode.removeChild(header);"];
        // 删除顶部的购买
        [js appendString:@"var box = document.getElementsByClassName('cost-box')[0];"];
        [js appendString:@"box.parentNode.removeChild(box);"];
        // 删除底部的购买
        [js appendString:@"var buyNow = document.getElementsByClassName('buy-now')[0];"];
        [js appendString:@"buyNow.parentNode.removeChild(buyNow);"];
        
        // 利用webView执行JS
        [webView stringByEvaluatingJavaScriptFromString:js];
        
//         获得页面
//        NSString *html = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].outerHTML;"];
        // 显示webView
//        webView.hidden = NO;
        // 隐藏正在加载
        [self.loadingView stopAnimating];
    }
}

@end
