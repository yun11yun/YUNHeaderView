//
//  YUNZoomScrollView.m
//  YUNScrollHeaderView
//
//  Created by bit_tea on 16/4/25.
//  Copyright © 2016年 Tordian. All rights reserved.
//

#import "YUNZoomScrollView.h"

@interface YUNZoomScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *animationTimer;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, assign) NSInteger totalPageCount;

@property (nonatomic, strong) NSMutableArray *contentViews;

@property (nonatomic, strong) NSMutableArray *subContentViews;

@property (nonatomic, strong) NSMutableArray *carouseArray;

@end

@implementation YUNZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
            animationDuration:(NSTimeInterval)animationDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
            scrollView.autoresizingMask = 0xFF;
            scrollView.contentMode = UIViewContentModeCenter;
            scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(scrollView.frame), 0);
            scrollView.delegate = self;
            scrollView.contentOffset = CGPointMake(CGRectGetWidth(scrollView.frame), 0);
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.backgroundColor = [UIColor whiteColor];
            [self addSubview:scrollView];
            scrollView;
        });
        _currentPageIndex = 0;
        
        if (animationDuration > 0.0) {
            _animationDuration = animationDuration;
            _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
        }
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame animationDuration:0.0];
}

- (NSMutableArray *)subContentViews
{
    if (_subContentViews == nil) {
        _subContentViews = [NSMutableArray array];
    }
    return _subContentViews;
}

- (void)setImageNames:(NSArray *)imageNames
{
    if (imageNames && imageNames.count != 0) {
        _carouseArray = [NSMutableArray arrayWithCapacity:imageNames.count];
    }
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    if (imageURLs && imageURLs.count != 0) {
        _carouseArray = [NSMutableArray arrayWithCapacity:imageURLs.count];
        
        for (int i = 0; i < imageURLs.count; i ++) {
            UIImage *image = [[UIImage alloc] init];
            [_carouseArray addObject:image];
        }
    }
}

- (void)setSubImageViewWithImages:(NSArray *)images withURLType:(BOOL)url
{
    
}

#pragma mark - Actions

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) + CGRectGetWidth(_scrollView.frame), _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
}

#pragma mark - Override Methods

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    CGRect frame = self.scrollView.frame;
    
}

- (CGFloat)frameOffset
{
    return 20.f;
}

- (CGFloat)frameOffsetTrainsitionRate
{
    return 0.3f;
}

@end
