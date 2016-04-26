//
//  ViewController.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+YUNHeader.h"
#import "UIKit+YUNExtension.h"
#import "YUNZoomHeaderControl.h"

#import "YUNHeaderView.h"
#import "YUNZoomBannerView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YUNBannerViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) YUNZoomBannerView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.contentSize = CGSizeMake(self.view.yun_width, self.view.yun_height * 2);
    _tableView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _headerView = [[YUNZoomBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 240)];
    _headerView.dataSource = self;
    _headerView.shouldLoop = YES;
    _headerView.pageControl.hidden = YES;
    [self.tableView addHeaderView:_headerView];
    
    YUNZoomHeaderControl *zoomControl = [[YUNZoomHeaderControl alloc] init];
    [self.tableView addHeaderControl:zoomControl];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

#pragma mark - YUNBannerViewDelegate

- (NSInteger)numberOfItemsInBanner:(YUNZoomBannerView *)banner
{
    return self.dataArray.count;
}

- (UIImage *)banner:(YUNZoomBannerView *)banner imageForItemAtIndex:(NSInteger)index
{
    // 取出数据
    NSString *imageName = self.dataArray[index];
    
    return [UIImage imageNamed:imageName];
}

#pragma mark Getter

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"qiong.jpg", @"qiong1.jpg", @"qiong2.jpg"];
    }
    return _dataArray;
}

@end
