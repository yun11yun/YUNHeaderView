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
#import "YUNZoomScrollView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,YUNZoomScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) YUNZoomScrollView *headerView;

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
    
    _headerView = [[YUNZoomScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 240)];
    _headerView.delegate = self;
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

#pragma mark - YUNZoomScrollViewDelegate

- (NSInteger)numberOfItemInZoomScrollView:(YUNZoomScrollView *)scrollView
{
    return [self images].count;
}

- (UIImage *)zoomScrollView:(YUNZoomScrollView *)scrollView placeholderImageForItemAtIndex:(NSInteger)index
{
    return [self images][index];
}

- (void)zoomScrollView:(YUNZoomScrollView *)scrollView didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"selected %ld",index);
}

- (NSArray *)images
{
    return @[[UIImage imageNamed:@"qiong.jpg"],[UIImage imageNamed:@"qiong1.jpg"],[UIImage imageNamed:@"qiong2.jpg"], [UIImage imageNamed:@"test.jpg"]];
}

@end
