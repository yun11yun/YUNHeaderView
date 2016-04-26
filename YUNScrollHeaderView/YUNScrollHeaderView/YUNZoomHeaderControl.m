//
//  YUNZoomHeaderControl.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "YUNZoomHeaderControl.h"
#import "UIKit+YUNExtension.h"

@implementation YUNZoomHeaderControl

- (void)resetHeaderViewWithInfo:(UIScrollViewScrollInfo *)info
{
    CGRect frame = self.headerView.frame;
    
    CGFloat change = - (info.newContentOffset.y - info.oldContentOffset.y);

    //得到向下偏移量,并矫正
    CGFloat frameOffset = [self.headerView frameOffset];
    frameOffset = frameOffset < 0.f ? 0.f : frameOffset;
    frameOffset = frameOffset > self.headerView.originFrame.size.height ? self.headerView.originFrame.size.height : frameOffset;
    
    //得到变换速率,并矫正
    CGFloat frameOffsetTrainsitionRate = [self.headerView frameOffsetTrainsitionRate];
    frameOffsetTrainsitionRate = frameOffsetTrainsitionRate > 1.f ? 1.f : frameOffsetTrainsitionRate;
    frameOffsetTrainsitionRate = frameOffsetTrainsitionRate < 0.f ? 0.f : frameOffsetTrainsitionRate;
    
    if (frameOffset > 0.f &&
        - info.scrollingScrollView.contentOffset.y < self.headerView.frame.size.height) {
        frame.size.height += change * frameOffsetTrainsitionRate;
        frame.size.width += change * frameOffsetTrainsitionRate;
    } else {
        frame.size.height += change;
        frame.size.width += change;
    }
    
    frame.origin.y -= change;
    
    CGFloat originHeight = self.headerView.originFrame.size.height;
    CGFloat originY = self.headerView.originFrame.origin.y;
    CGFloat originWidth = self.headerView.originFrame.size.width;
    
    if (info.scrollDirection == UIScrollViewScrollDirectionToTop) {
        frame.origin.y = frame.origin.y > originY ? originY : frame.origin.y;
        
        frame.size.height = frame.size.height < originHeight ? originHeight : frame.size.height;
        frame.size.width = frame.size.width < originWidth ? originWidth : frame.size.width;
        
        if (info.newContentOffset.y > originY) {
            frame.origin.y = info.newContentOffset.y;
        }
    }
    
    //向下滑且headerView不在屏幕中
    if (info.scrollDirection == UIScrollViewScrollDirectionToBottom &&
        info.newContentOffset.y > originY) {
        frame.origin.y = frame.origin.y <  originY ? originY : frame.origin.y;
        frame.size.height = frame.size.height > originHeight ? originHeight : frame.size.height;
        frame.size.width = frame.size.width > originWidth ? originWidth : frame.size.width;
    }
    
    CGFloat currentOffset = frameOffset + (info.scrollingScrollView.contentOffset.y - originY) * frameOffsetTrainsitionRate;
    currentOffset = currentOffset < 0.f ? 0.f : currentOffset;
    currentOffset = currentOffset > frameOffset ? frameOffset : currentOffset;
    
    if (info.scrollingScrollView.contentOffset.y != self.headerView.frame.origin.y + currentOffset &&
        info.newContentOffset.y < originY &&
        info.newContentOffset.y < 0)
    {
        frame.origin.y = info.scrollingScrollView.contentOffset.y;
        frame.size.height = - frame.origin.y + currentOffset;
        frame.size.width = frame.size.height / originHeight * originWidth;
        frame.origin.x = originWidth - frame.size.width;
    }
    
    self.headerView.frame = frame;
    
    //修正中心点
    CGPoint center = self.headerView.center;
    center.x = info.scrollingScrollView.frame.size.width / 2;
    self.headerView.center = center;
}

@end
