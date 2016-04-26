//
//  YUNHeaderView.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNHeaderView.h"

@implementation YUNHeaderView
{
    UIView *_overlayView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _overlayView = [[UIView alloc] initWithFrame:self.bounds];
        _overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        _overlayView.alpha = 0.0;
        [self addSubview:_overlayView];
    }
    return self;
}

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    if (info.newContentOffset.y > self.originFrame.origin.y) {
        _overlayView.alpha = (self.originFrame.origin.y - info.newContentOffset.y) / self.originFrame.origin.y;
    } else {
        _overlayView.alpha = 0.0f;
    }
}

- (CGFloat)maxmumHeight
{
    return 240.f;
}

- (CGFloat)frameOffsetTrainsitionRate
{
    return 0.1f;
}

- (CGFloat)frameOffset
{
    return 0.0f;
}

@end
