//
//  YUNZoomScrollViewCell.m
//  YUNZoomScrollView
//
//  Created by Orange on 3/27/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNZoomScrollViewCell.h"

@implementation YUNZoomScrollViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

@end
