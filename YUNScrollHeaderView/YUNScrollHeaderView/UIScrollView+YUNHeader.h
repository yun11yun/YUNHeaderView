//
//  UIScrollView+YUNHeader.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YUNHeaderViewControl;
@class YUNBaseHeaderView;

@interface UIScrollView (YUNHeader)

@property (nonatomic, strong, readonly) YUNBaseHeaderView *yun_headerView;

@property (nonatomic, strong, readonly) YUNHeaderViewControl *yun_control;

- (void)addHeaderView:(YUNBaseHeaderView *)headerView;

- (void)removeHeaderView;

- (void)addHeaderControl:(YUNHeaderViewControl *)control;

@end
