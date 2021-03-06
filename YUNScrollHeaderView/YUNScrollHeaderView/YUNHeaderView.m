//
//  YUNHeaderView.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/26/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNHeaderView.h"

@implementation YUNHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _hierarchy = YUNHeaderViewHierarchyBackground;
}

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    
}

- (CGFloat)frameOffset
{
    return 0.f;
}

- (CGFloat)frameOffsetTrainsitionRate
{
    return 0.5f;
}

@end
