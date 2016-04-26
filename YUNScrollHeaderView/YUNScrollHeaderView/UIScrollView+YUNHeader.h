//
//  UIScrollView+YUNHeader.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNHeaderViewProtocol.h"

@class YUNHeaderViewControl;

@interface UIScrollView (YUNHeader)

@property (nonatomic, strong, readonly) UIView<YUNHeaderViewProtocol> *yun_headerView;

@property (nonatomic, strong, readonly) YUNHeaderViewControl *yun_control;

- (void)addHeaderView:(UIView<YUNHeaderViewProtocol> *)headerView;

- (void)removeHeaderView;

- (void)addHeaderControl:(YUNHeaderViewControl *)control;

@end
