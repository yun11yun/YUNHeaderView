//
//  YUNBannerView.h
//  YUNBannerDemo
//
//  Created by Orange on 4/26/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNBannerFooter.h"
#import "YUNHeaderViewProtocol.h"

@protocol YUNBannerViewDelegate;
@protocol YUNBannerViewDataSource;

@interface YUNZoomBannerView : UIView <YUNHeaderViewProtocol>

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) YUNHeaderViewHierarchy hierarchy;

/**
 *  是否需要循环滚动， 默认为NO
 */
@property (nonatomic, assign) IBInspectable BOOL shouldLoop;

/**
 *  是否显示footer， 默认为 NO (此属性为YES时， shouldLoop会被置为NO)
 */
@property (nonatomic, assign) IBInspectable BOOL showFooter;

/**
 *  是否自动滑动，默认为 NO
 */
@property (nonatomic, assign) IBInspectable BOOL autoScroll;

/**
 *  自动滑动间隔时间(s), 默认为 3.0
 */
@property (nonatomic, assign) IBInspectable NSTimeInterval scrollInterval;

/**
 *  pageControl, 可自由配置其属性
 */
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet id<YUNBannerViewDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<YUNBannerViewDelegate> delegate;

- (void)reloadData;

- (void)startTimer;
- (void)stopTimer;

@end

@protocol YUNBannerViewDataSource <NSObject>

@required

- (NSInteger)numberOfItemsInBanner:(YUNZoomBannerView *)banner;
- (UIImage *)banner:(YUNZoomBannerView *)banner imageForItemAtIndex:(NSInteger)index;

@optional

- (NSString *)banner:(YUNZoomBannerView *)banner titleForFooterWithState:(YUNBannerFooterState)footerState;

@end


@protocol YUNBannerViewDelegate <NSObject>

@optional

- (void)banner:(YUNZoomBannerView *)banner didSelectItemAtIndex:(NSInteger)index;
- (void)bannerFooterDidTrigger:(YUNZoomBannerView *)banner;

@end