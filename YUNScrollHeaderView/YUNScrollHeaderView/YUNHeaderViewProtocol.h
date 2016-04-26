//
//  YUNHeaderViewProtocol.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/26/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollViewScrollInfo.h"

typedef NS_ENUM(NSInteger, YUNHeaderViewHierarchy)
{
    /**
     *  在scrollView的最前面
     */
    YUNHeaderViewHierarchyFront = 1,
    
    /**
     *  在scrollView的最后面
     */
    YUNHeaderViewHierarchyBackground = 2,
};

@protocol YUNHeaderViewProtocol <NSObject>

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) YUNHeaderViewHierarchy hierarchy;

@optional

- (CGFloat)maximumHeight;

- (CGFloat)frameOffset;

- (CGFloat)frameOffsetTrainsitionRate;

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info;

@end
