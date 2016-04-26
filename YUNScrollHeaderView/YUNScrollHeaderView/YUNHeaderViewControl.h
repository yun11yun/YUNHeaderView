//
//  YUNHeaderViewControl.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewContentOffsetObserver.h"
#import "YUNBaseHeaderView.h"

@class YUNBaseHeaderView;

@interface YUNHeaderViewControl : NSObject<UIScrollViewContentOffsetObserverDelegate>

@property (nonatomic, strong) YUNBaseHeaderView *headerView;

// 由子类覆写 
- (void)resetHeaderViewWithInfo:(UIScrollViewScrollInfo *)info;

@end
