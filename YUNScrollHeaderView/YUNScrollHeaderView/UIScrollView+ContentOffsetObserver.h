//
//  UIScrollView+ContentOffsetObserver.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollViewContentOffsetObserver.h"

@interface UIScrollView (ContentOffsetObserver)

@property (nonatomic, strong, readonly) UIScrollViewContentOffsetObserver *contentOffsetObserver;

@end
