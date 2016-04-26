//
//  ViewController.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+YUNHeader.h"
#import "YUNHeaderView.h"
#import "UIKit+YUNExtension.h"
#import "YUNZoomHeaderControl.h"
#import "YUNZoomScrollView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

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
    
    YUNZoomScrollView *headerView = [[YUNZoomScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.yun_width, 200)];
    headerView.backgroundColor = [UIColor orangeColor];
//    headerView.layer.contents = (id)[UIImage imageNamed:@"test.jpg"].CGImage;
    [self.tableView addHeaderView:headerView];
    
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

@end
