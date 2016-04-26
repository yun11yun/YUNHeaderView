//
//  YUNHeaderViewControl.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNHeaderViewControl.h"
#import "UIScrollViewScrollInfo.h"
#import "UIKit+YUNExtension.h"

@implementation YUNHeaderViewControl

- (void)didOffsetChangedWithScrollViewScrollInfo:(UIScrollViewScrollInfo *)info
{
    switch (self.headerView.hierarchy) {
        case YUNHeaderViewHierarchyBackground:
            [info.scrollingScrollView sendSubviewToBack:self.headerView];
            break;
        case YUNHeaderViewHierarchyFront:
            [info.scrollingScrollView bringSubviewToFront:self.headerView];
            break;
    }
    
    [self resetHeaderViewWithInfo:info];
    [self resetHeaderViewSubviewsWithInfo:info];
    
    
}

- (void)resetHeaderViewWithInfo:(UIScrollViewScrollInfo *)info
{
}

- (void)resetHeaderViewSubviewsWithInfo:(UIScrollViewScrollInfo *)info
{
    [self.headerView resetSubviewsWithScrollInfo:info];
}

@end
