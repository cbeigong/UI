//
//  MTDealsViewController.m
//  美团HD
//
//  Created by clm on 15/9/1.
//  Copyright (c) 2015年 clm. All rights reserved.
//

#import "MTDealsViewController.h"
#import "MJRefresh.h"
#import "DPAPI.h"
#import "UIView+AutoLayout.h"
#import "MTDeal.h"
#import "MJExtension.h"
#import "UIView+Extension.h"
#import "MTConst.h"
#import "MTDealCell.h"
#import "MTDetailViewController.h"
@interface MTDealsViewController () <DPRequestDelegate>
/** 所有的团购数据 */
@property (nonatomic, strong) NSMutableArray *deals;
@property (nonatomic, weak) UIImageView *noDataView;

/** 记录当前页码 */
@property (nonatomic, assign) int  currentPage;
/** 总数 */
@property (nonatomic, assign) int  totalCount;

/** 最后一个请求 */
@property (nonatomic, weak) DPRequest *lastRequest;

@end

@implementation MTDealsViewController

static NSString * const reuseIdentifier = @"deal";
- (NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}

- (UIImageView *)noDataView
{
    if (!_noDataView) {
        UIImageView *nodataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        [self.view addSubview:nodataView];
        // 添加自动布局
        [nodataView autoCenterInSuperview];
        self.noDataView = nodataView;
    }
    return _noDataView;
}

- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell  的大小
    layout.itemSize = CGSizeMake(305, 305);
//    NSLog(@"%@========================================", layout.itemSize);
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景色
    self.collectionView.backgroundColor = MTGlobalBg;
    
//    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    
    self.collectionView.alwaysBounceVertical = YES;
    // Do any additional setup after loading the view.
    [self.collectionView registerNib:[UINib nibWithNibName:@"MTDealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
 
    // 添加上拉刷新 所以每次刷新都时候都会跟服务器， 进行交互
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
}

#warning 此处先不管
/**
 当屏幕旋转,控制器view的尺寸发生改变调用
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // 根据屏幕宽度决定列数
    int cols = (size.width == 1024) ? 3 : 2;
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
}

#pragma mark - 跟服务器交互
- (void)loadDeals
{
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    // 调用子类的实现方法
    [self setupParams:params];
    //
    params[@"limit"] = @20;
    // 页码
    params[@"page"] = @(self.currentPage);
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void)loadNewDeals
{
    self.currentPage = 1;
    [self loadDeals];
}

- (void)loadMoreDeals
{
    self.currentPage++;
    [self loadDeals];
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    // 不是最新的请求 就直接放弃result；
    if (request != self.lastRequest) return ;
//    NSLog(@"%@", result);
    self.totalCount = [result[@"total_count"] intValue];
    
    // 传回来的是一个字典数组， 你要将他转为模型数组
    NSArray *newDeals = [MTDeal objectArrayWithKeyValuesArray:result[@"deals"]];
    if (self.currentPage == 1) {// 清楚之前的数据
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray:newDeals];
    
    // 刷新表格
    [self.collectionView reloadData];
    
    // 数据返回成功之后就结束上啦刷新， 或者下啦刷新
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    
}
#pragma mark <UICollectionViewDataSource>



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
#warning 此处再看
    // 计算一遍内边距
    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    
    // 控制没有数据的提醒
    self.noDataView.hidden = (self.deals.count != 0);
    return self.deals.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath]; 此处但Cell 换成是自定义的cell
    
    MTDealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MTDetailViewController *detailVc = [[MTDetailViewController alloc] init];
    detailVc.deal = self.deals[indexPath.item];
    [self presentViewController:detailVc animated:YES completion:nil];
    
}
@end
