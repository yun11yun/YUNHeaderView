//
//  UIScrollViewContentOffsetObserver.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIScrollViewContentOffsetObserver.h"

NSString * const ContentOffsetKeyPath = @"contentOffset";

@implementation UIScrollViewContentOffsetObserver

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:ContentOffsetKeyPath]) {
        
        UIScrollViewScrollInfo *info = [[UIScrollViewScrollInfo alloc] initWithChanage:change scrollingScrollView:object target:self.delegate];
        
        [self.delegate didOffsetChangedWithScrollViewScrollInfo:info];
        
        for (id<UIScrollViewContentOffsetObserverDelegate> delegate in self.delegates) {
            [delegate didOffsetChangedWithScrollViewScrollInfo:info];
        }
        
    }
}

#pragma mark - Setter & Getter
- (NSMutableArray *)delegates
{
    if (!_delegates) {
        _delegates = [[NSMutableArray alloc] init];
    }
    return _delegates;
}

#pragma mark - Control
- (void)addDelegate:(id<UIScrollViewContentOffsetObserverDelegate>)delegate
{
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<UIScrollViewContentOffsetObserverDelegate>)delegate
{
    [self.delegates removeObject:delegate];
}

@end
