//
//  UIView+YUNExtension.m
//  YUNUIKit
//
//  Created by Orange on 3/11/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIView+YUNExtension.h"

@implementation UIView (YUNExtension)

- (void)setYun_x:(CGFloat)yun_x
{
    CGRect frame = self.frame;
    frame.origin.x = yun_x;
    self.frame = frame;
}

- (CGFloat)yun_x
{
    return self.frame.origin.x;
}

- (void)setYun_y:(CGFloat)yun_y
{
    CGRect frame = self.frame;
    frame.origin.y = yun_y;
    self.frame = frame;
}

- (CGFloat)yun_y
{
    return self.frame.origin.y;
}

- (void)setYun_width:(CGFloat)yun_width
{
    CGRect frame = self.frame;
    frame.size.width = yun_width;
    self.frame = frame;
}

- (CGFloat)yun_width
{
    return self.frame.size.width;
}

- (void)setYun_height:(CGFloat)yun_height
{
    CGRect frame = self.frame;
    frame.size.height = yun_height;
    self.frame = frame;
}

- (CGFloat)yun_height
{
    return self.frame.size.height;
}

- (void)setYun_size:(CGSize)yun_size
{
    CGRect frame = self.frame;
    frame.size = yun_size;
    self.frame = frame;
}

- (CGSize)yun_size
{
    return self.frame.size;
}

- (void)setYun_origin:(CGPoint)yun_origin
{
    CGRect frame = self.frame;
    frame.origin = yun_origin;
    self.frame = frame;
}

- (CGPoint)yun_origin
{
    return self.frame.origin;
}

@end
