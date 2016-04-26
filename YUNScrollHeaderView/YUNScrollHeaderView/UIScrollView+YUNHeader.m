//
//  UIScrollView+YUNHeader.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIScrollView+YUNHeader.h"
#import <objc/runtime.h>
#import "UIKit+YUNExtension.h"
#import "YUNHeaderViewControl.h"
#import "UIScrollView+ContentOffsetObserver.h"
#import "YUNBaseHeaderView.h"

@implementation UIScrollView (YUNHeader)

#pragma mark - Setter & Getter

- (void)setYun_headerView:(YUNBaseHeaderView *)yun_headerView
{
    objc_setAssociatedObject(self, @selector(yun_headerView), yun_headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YUNBaseHeaderView *)yun_headerView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYun_control:(YUNHeaderViewControl *)yun_control
{
    objc_setAssociatedObject(self, @selector(yun_control), yun_control, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YUNHeaderViewControl *)yun_control
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)addHeaderView:(YUNBaseHeaderView *)headerView
{
    [self.yun_headerView removeFromSuperview];
    self.yun_headerView = headerView;
    [self addSubview:self.yun_headerView];
    [self sendSubviewToBack:self.yun_headerView];
    
    self.yun_control = [self defaultHeaderControl];
    self.yun_control.headerView = self.yun_headerView;
    [self.contentOffsetObserver addDelegate:self.yun_control];
    
    [self resetHeaderViewFrame];
    [self resetContentInset];
}

- (YUNHeaderViewControl *)defaultHeaderControl
{
    return [[YUNHeaderViewControl alloc] init];
}

- (void)removeHeaderView
{
    [self.yun_headerView removeFromSuperview];
    self.yun_headerView = nil;
    
    UIEdgeInsets insets = self.contentInset;
    insets.top = 0.f;
    [self setContentInset:insets];
    self.scrollIndicatorInsets = insets;
    
    [self.contentOffsetObserver removeDelegate:self.yun_control];
}

- (void)addHeaderControl:(YUNHeaderViewControl *)control
{
    if (control) {
        self.yun_control = nil;
        self.yun_control = control;
        self.yun_control.headerView = self.yun_headerView;
        [self.contentOffsetObserver addDelegate:self.yun_control];
    }
}

#pragma mark - Helper Methods

- (void)resetHeaderViewFrame
{
    CGFloat offset = self.yun_headerView.frameOffset;
    
    self.yun_headerView.yun_x = 0;
    self.yun_headerView.yun_y = - self.yun_headerView.yun_height + offset;
    
    self.yun_headerView.originFrame = self.yun_headerView.frame;
}

- (void)resetContentInset
{
    CGFloat topInset = - self.yun_headerView.originFrame.origin.y;
    
    self.yun_insetT = topInset;
    
    self.yun_offsetY = - self.yun_insetT;
}

@end
