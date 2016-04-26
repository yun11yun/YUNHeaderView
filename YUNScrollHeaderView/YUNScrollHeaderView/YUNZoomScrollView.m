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
        _imageNames = [imageNames copy];
        _carouseArray = [NSMutableArray arrayWithCapacity:imageNames.count];
        [self setSubImageViewWithImages:_imageNames withURLType:NO];
        [self configureContentViews];
    }
}

- (void)setImageURLs:(NSArray *)imageURLs
{
    if (imageURLs && imageURLs.count != 0) {
        _imageURLs = [imageURLs copy];
        _carouseArray = [NSMutableArray arrayWithCapacity:imageURLs.count];
        
        for (int i = 0; i < imageURLs.count; i ++) {
            UIImage *image = [[UIImage alloc] init];
            [_carouseArray addObject:image];
        }
        [self setSubImageViewWithImages:_imageURLs withURLType:YES];
        [self configureContentViews];
    }
}

- (void)setSubImageViewWithImages:(NSArray *)images withURLType:(BOOL)url
{
    self.totalPageCount = images.count;
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    
    if (images.count > 2) {
        for (int i = 0; i < images.count; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            if (url) {
                
            } else {
                imageView.image = [UIImage imageNamed:images[i]];
            }
            [viewsArray addObject:imageView];
        }
    } else if (images.count == 2) {
        for (int i = 0; i < images.count * 2; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            if (url) {
                
            } else {
                imageView.image = [UIImage imageNamed:images[i % 2]];
            }
            [viewsArray addObject:imageView];
        }
    } else {
        for (int i = 0; i < images.count * 4; i ++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame))];
            if (url) {
                
            } else {
                imageView.image = [UIImage imageNamed:images[i]];
            }
            [viewsArray addObject:imageView];
        }
    }
    self.subContentViews =  viewsArray;
}

- (void)configureContentViews
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * counter, 0);
        counter ++;
        contentView.frame = rightRect;
        [_scrollView addSubview:contentView];
    }
}

- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    if ([self featchContentViewAtIndex:self.currentPageIndex]) {
        [self.contentViews addObject:[self featchContentViewAtIndex:previousPageIndex]];
        [self.contentViews addObject:[self featchContentViewAtIndex:self.currentPageIndex]];
        [self.contentViews addObject:[self featchContentViewAtIndex:rearPageIndex]];
    }
    if (self.totalPageCount > 1) {
        self.scrollView.scrollEnabled = YES;
    } else {
        self.scrollView.scrollEnabled = NO;
    }
}

- (UIView *)featchContentViewAtIndex:(NSInteger)index
{
    return self.subContentViews[index];
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex
{
    if (self.totalPageCount > 2) {
        if(currentPageIndex == -1) {
            return self.totalPageCount - 1;
        } else if (currentPageIndex == self.totalPageCount) {
            return 0;
        } else {
            return currentPageIndex;
        }
    } else if (self.totalPageCount == 2){
        if(currentPageIndex == -1) {
            return (self.totalPageCount * 2 - 1);
        } else if (currentPageIndex == self.totalPageCount * 2) {
            return 0;
        } else {
            return currentPageIndex;
        }
    } else {
        if(currentPageIndex == -1) {
            return (self.totalPageCount * 4 - 1);
        } else if (currentPageIndex == self.totalPageCount * 4) {
            return 0;
        } else {
            return currentPageIndex;
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.totalPageCount > 1) {
        
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.totalPageCount > 1) {
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_carouseArray == nil || _carouseArray.count == 0) {
        return;
    }
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        [self configureContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        [self configureContentViews];
    }
}

#pragma mark - Actions

- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointMake(CGRectGetWidth(_scrollView.frame) + CGRectGetWidth(_scrollView.frame), _scrollView.contentOffset.y);
    [_scrollView setContentOffset:newOffset animated:YES];
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)recognizer
{
    
}

#pragma mark - Override Methods

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    CGRect scrollFrame = _scrollView.frame;
    _scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollFrame) * 3, 0);
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        CGRect rightRect = contentView.frame;
        rightRect.origin = CGPointMake(CGRectGetWidth(_scrollView.frame) * counter, 0);
        rightRect.size = CGSizeMake(CGRectGetWidth(scrollFrame), CGRectGetHeight(scrollFrame));
        counter ++;
        contentView.frame = rightRect;
        [_scrollView addSubview:contentView];
    }
    
    
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
