//
//  UIScrollViewContentOffsetObserver.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIScrollViewScrollInfo.h"

extern NSString * const ContentOffsetKeyPath;

@class UIScrollViewContentOffsetObserver;

@protocol UIScrollViewContentOffsetObserverDelegate <NSObject>

- (void)didOffsetChangedWithScrollViewScrollInfo:(UIScrollViewScrollInfo *)info;

@end

@interface UIScrollViewContentOffsetObserver : NSObject

@property (nonatomic, weak) id<UIScrollViewContentOffsetObserverDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *delegates;

- (void)addDelegate:(id<UIScrollViewContentOffsetObserverDelegate>)delegate;

- (void)removeDelegate:(id<UIScrollViewContentOffsetObserverDelegate>)delegate;

@end
