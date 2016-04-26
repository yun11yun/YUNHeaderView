//
//  YUNBaseHeaderView.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNBaseHeaderView.h"

@implementation YUNBaseHeaderView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _hierarchy = YUNHeaderViewHierarchyBackground;
    }
    return self;
}

- (CGFloat)maximumHeight
{
    return 240.f;
}

- (CGFloat)frameOffset
{
    return 50.0f;
}

- (CGFloat)frameOffsetTrainsitionRate
{
    return 0.5f;
}

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    
}

@end
