//
//  UIScrollView+YUNExtension.h
//  YUNTools
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (YUNExtension)

@property (nonatomic, assign) CGFloat yun_insetT;
@property (nonatomic, assign) CGFloat yun_insetB;
@property (nonatomic, assign) CGFloat yun_insetL;
@property (nonatomic, assign) CGFloat yun_insetR;

@property (nonatomic, assign) CGFloat yun_offsetX;
@property (nonatomic, assign) CGFloat yun_offsetY;

@property (nonatomic, assign) CGFloat yun_contentW;
@property (nonatomic, assign) CGFloat yun_contentH;

@end
