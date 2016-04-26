//
//  YUNHeaderViewControl.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewContentOffsetObserver.h"
#import "YUNHeaderViewProtocol.h"

@class YUNBaseHeaderView;

@interface YUNHeaderViewControl : NSObject<UIScrollViewContentOffsetObserverDelegate>

@property (nonatomic, strong) UIView<YUNHeaderViewProtocol> *headerView;

// 由子类覆写 
- (void)resetHeaderViewWithInfo:(UIScrollViewScrollInfo *)info;

@end
