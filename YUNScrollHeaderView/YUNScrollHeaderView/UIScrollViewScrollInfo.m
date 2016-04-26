//
//  UIScrollViewScrollInfo.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIScrollViewScrollInfo.h"
#import "UIScrollViewContentOffsetObserver.h"

@implementation UIScrollViewScrollInfo

- (instancetype)initWithChanage:(NSDictionary *)change
            scrollingScrollView:(UIScrollView *)scrollingScrollView
                         target:(id<UIScrollViewContentOffsetObserverDelegate>)target
{
    self = [self init];
    
    if (self) {
        
        self.scrollingScrollView = scrollingScrollView;
        self.target = target;
        
        self.oldContentOffset = [change[NSKeyValueChangeOldKey] CGPointValue];
        self.newContentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        
        if (self.oldContentOffset.x > self.newContentOffset.x) {
            self.scrollDirection = UIScrollViewScrollDirectionToLeft;
        }
        if (self.oldContentOffset.x < self.newContentOffset.x) {
            self.scrollDirection = UIScrollViewScrollDirectionToRight;
        }
        if (self.oldContentOffset.y > self.newContentOffset.y) {
            self.scrollDirection = UIScrollViewScrollDirectionToBottom;
        }
        if (self.oldContentOffset.y < self.newContentOffset.y) {
            self.scrollDirection = UIScrollViewScrollDirectionToTop;
        }
        
        self.contentOffsetSection = CGPointMake(fabs(self.newContentOffset.x - self.oldContentOffset.x), fabs(self.newContentOffset.y - self.oldContentOffset.y));
        
    }
    
    return self;
}


@end
