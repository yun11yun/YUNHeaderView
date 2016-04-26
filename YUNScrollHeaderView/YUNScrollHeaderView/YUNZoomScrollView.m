//
//  YUNZoomScrollView.m
//  YUNZoomScrollView
//
//  Created by Orange on 3/27/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNZoomScrollView.h"
#import "UIScrollViewScrollInfo.h"
#import "NSTimer+Control.h"
#import "YUNZoomScrollViewCell.h"

@interface YUNZoomScrollView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) NSTimer *animationTimer;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong, readwrite) UICollectionView *collectionView;

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, assign) NSInteger currentPageIndex;

@property (nonatomic, assign) CGFloat originWidth;

@property (nonatomic, assign) CGFloat originHeight;

@property (nonatomic, strong) UIImageView *stretchImageView;

@property (nonatomic, strong) UIView *overlayView;

@end

static NSString * const kCellIdentifier = @"cellIdentifier";

static CGFloat oldContentOffsetX = 0.0f;

@implementation YUNZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame animationDuration:0.0];
}

- (instancetype)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)aniamtionDuration
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = YES;
        
        _originWidth = frame.size.width;
        _originHeight = frame.size.height;
        _enableStretch = NO;
        _currentPageIndex = 0;
        if (aniamtionDuration > 0.0) {
            _animationDuration = aniamtionDuration;
            _animationTimer = [NSTimer scheduledTimerWithTimeInterval:_animationDuration
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
            [_animationTimer pauseTimer];
        }
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        _flowLayout = flowLayout;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[YUNZoomScrollViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        [self addSubview:_collectionView];
        
        _stretchImageView = [[UIImageView alloc] init];
        _stretchImageView.hidden = YES;
        [self addSubview:_stretchImageView];
        
        _overlayView = [[UIView alloc] init];
        _overlayView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:1.0];
        _overlayView.alpha = 0.0;
        _overlayView.userInteractionEnabled = NO;
        [self addSubview:_overlayView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _flowLayout.itemSize = self.bounds.size;
    _collectionView.frame = self.bounds;
    
    _overlayView.frame = self.bounds;
}

- (void)setDelegate:(id<YUNZoomScrollViewDelegate>)delegate
{
    if (delegate) {
        _delegate = delegate;
        [self.collectionView reloadData];
        [self performSelector:@selector(startAnimationTimer) withObject:nil afterDelay:20];
    }
}

- (UIImage *)imageAtIndex:(NSInteger)index
{
    YUNZoomScrollViewCell *cell = (YUNZoomScrollViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if (cell) {
        if (cell.imageView.image) {
            return cell.imageView.image;
        }
    }
    return nil;
}

#pragma mark - Private Methods

- (void)startAnimationTimer
{
    [_animationTimer resumeTimer];
}

- (void)animationTimerDidFired:(NSTimer *)sender
{
    if (_currentPageIndex == [self.delegate numberOfItemInZoomScrollView:self] - 1) {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    } else {
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:(_currentPageIndex + 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    }
}

- (void)setupImageForImageView:(UIImageView *)imageView atIndex:(NSInteger)index
{
    if ([self imageURLForIndex:index]) {
        
        
    } else {
        imageView.image = [self placeholderImageForIndex:index];
    }
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self itemCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YUNZoomScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self setupImageForImageView:cell.imageView atIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zoomScrollView:didSelectedItemAtIndex:)]) {
        [self.delegate zoomScrollView:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentContentOffsetX = scrollView.contentOffset.x;
    CGFloat deltaContentOffsetX = currentContentOffsetX - oldContentOffsetX;
    if (deltaContentOffsetX >= CGRectGetWidth(scrollView.frame) * 0.75) {
        _currentPageIndex = _currentPageIndex + 1;
        oldContentOffsetX = _currentPageIndex * CGRectGetWidth(scrollView.bounds);
    }
    if (deltaContentOffsetX <= - CGRectGetWidth(scrollView.frame) * 0.75) {
        _currentPageIndex = _currentPageIndex - 1;
        oldContentOffsetX = _currentPageIndex * CGRectGetWidth(scrollView.bounds);
    }
}

#pragma mark - Delegate Methods

- (UIImage *)placeholderImageForIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zoomScrollView:placeholderImageForItemAtIndex:)]) {
        return [self.delegate zoomScrollView:self placeholderImageForItemAtIndex:index];
    }
    return nil;
}

- (NSURL *)imageURLForIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(zoomScrollView:imageURLForItemAtIndex:)]) {
        return [self.delegate zoomScrollView:self imageURLForItemAtIndex:index];
    }
    return nil;
}

- (NSInteger)itemCount
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberOfItemInZoomScrollView:)]) {
        return [self.delegate numberOfItemInZoomScrollView:self];
    }
    return 0;
}

#pragma mark - 图片拉伸

- (void)zoomScrollViewStretchingWithOffsetY:(CGFloat)offsetY
{
    if (!self.enableStretch) {
        return;
    }
    CGFloat originPercent = _originWidth / _originHeight;
    CGFloat height = _originHeight - offsetY;
    CGFloat width = _originWidth - offsetY * originPercent;
    if (offsetY < -1) {
        _collectionView.hidden = YES;
        _stretchImageView.hidden = NO;
        
        YUNZoomScrollViewCell *cell = (YUNZoomScrollViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPageIndex inSection:0]];
        _stretchImageView.image = cell.imageView.image;
        _stretchImageView.frame = CGRectMake(offsetY * originPercent / 2, 0, width, height);
    } else {
        _collectionView.hidden = NO;
        _stretchImageView.hidden = YES;
        _stretchImageView.frame = CGRectZero;
    }
}


#pragma mark - LJWZoomingHeaderViewProtocol

- (void)resetSubviewsWithScrollInfo:(UIScrollViewScrollInfo *)info
{
    CGFloat deltaY = info.newContentOffset.y + _originHeight - [self frameOffset];
    
    if (deltaY < 0) {
        
        CGRect rect = CGRectMake(_flowLayout.itemSize.width * _currentPageIndex, 0, _flowLayout.itemSize.width, _flowLayout.itemSize.height);
        [self.collectionView scrollRectToVisible:rect animated:NO];
        
        _overlayView.alpha = 0.0f;
        
    } else if (deltaY > 0) {
        CGFloat overlayAlpha = deltaY / (_originHeight - [self frameOffset]);
        _overlayView.alpha = overlayAlpha;
        
        self.frame = CGRectMake(0, - _originHeight + [self frameOffset] + deltaY, _originWidth, _originHeight);
    }
}

// header最大的高度
- (CGFloat)maximumHeight
{
    return 450.0f;
}

// header 往下的偏移量
- (CGFloat)frameOffset
{
    return 50.0f;
}

- (CGFloat)frameOffsetTrainsitionRate
{
    return 0.5f;
}


@end
