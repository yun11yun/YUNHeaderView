//
//  UIScrollView+YUNExtension.m
//  YUNTools
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIScrollView+YUNExtension.h"
#import <objc/runtime.h>

@implementation UIScrollView (YUNExtension)

- (void)setYun_insetT:(CGFloat)yun_insetT
{
    UIEdgeInsets inset = self.contentInset;
    inset.top = yun_insetT;
    self.contentInset = inset;
}

- (CGFloat)yun_insetT
{
    return self.contentInset.top;
}

- (void)setYun_insetB:(CGFloat)yun_insetB
{
    UIEdgeInsets inset = self.contentInset;
    inset.bottom = yun_insetB;
    self.contentInset = inset;
}

- (CGFloat)yun_insetB
{
    return self.contentInset.bottom;
}

- (void)setYun_insetL:(CGFloat)yun_insetL
{
    UIEdgeInsets inset = self.contentInset;
    inset.left = yun_insetL;
    self.contentInset = inset;
}

- (CGFloat)yun_insetL
{
    return self.contentInset.left;
}

- (void)setYun_insetR:(CGFloat)yun_insetR
{
    UIEdgeInsets inset = self.contentInset;
    inset.right = yun_insetR;
    self.contentInset = inset;
}

- (CGFloat)yun_insetR
{
    return self.contentInset.right;
}

- (void)setYun_offsetX:(CGFloat)yun_offsetX
{
    CGPoint offset = self.contentOffset;
    offset.x = yun_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)yun_offsetX
{
    return self.contentOffset.x;
}

- (void)setYun_offsetY:(CGFloat)yun_offsetY
{
    CGPoint offset = self.contentOffset;
    offset.y = yun_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)yun_offsetY
{
    return self.contentOffset.y;
}

- (void)setYun_contentW:(CGFloat)yun_contentW
{
    CGSize size = self.contentSize;
    size.width = yun_contentW;
    self.contentSize = size;
}

- (CGFloat)yun_contentW
{
    return self.contentSize.width;
}

- (void)setYun_contentH:(CGFloat)yun_contentH
{
    CGSize size = self.contentSize;
    size.height = yun_contentH;
    self.contentSize = size;
}

- (CGFloat)yun_contentH
{
    return self.contentSize.height;
}

@end
