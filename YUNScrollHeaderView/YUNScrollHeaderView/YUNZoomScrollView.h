//
//  YUNZoomScrollView.h
//  YUNZoomScrollView
//
//  Created by Orange on 3/27/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNHeaderViewProtocol.h"

@class YUNZoomScrollView;

@protocol YUNZoomScrollViewDelegate <NSObject>

@required
- (NSInteger)numberOfItemInZoomScrollView:(YUNZoomScrollView *)scrollView;

- (UIImage *)zoomScrollView:(YUNZoomScrollView *)scrollView placeholderImageForItemAtIndex:(NSInteger)index;

@optional
- (NSURL *)zoomScrollView:(YUNZoomScrollView *)scrollView imageURLForItemAtIndex:(NSInteger)index;

- (void)zoomScrollView:(YUNZoomScrollView *)scrollView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface YUNZoomScrollView : UIView <YUNHeaderViewProtocol>

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) YUNHeaderViewHierarchy hierarchy;

@property (nonatomic, strong, readonly) UICollectionView *collectionView;

@property (nonatomic, weak) id<YUNZoomScrollViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)aniamtionDuration;

- (UIImage *)imageAtIndex:(NSInteger)index;

@end
