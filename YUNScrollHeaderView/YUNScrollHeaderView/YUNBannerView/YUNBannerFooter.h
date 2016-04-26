//
//  YUNBannerFooter.h
//  YUNBannerDemo
//
//  Created by Orange on 4/26/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YUNBannerFooterState)
{
    YUNBannerFooterStateIdle = 0,    //正常状态下的footer提示
    YUNBannerFooterStateTrigger,     //被拖至触发点的footer提示
};

@interface YUNBannerFooter : UICollectionReusableView

@property (nonatomic, assign) YUNBannerFooterState state;

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *idleTitle;
@property (nonatomic, copy) NSString *triggerTitle;

@end
