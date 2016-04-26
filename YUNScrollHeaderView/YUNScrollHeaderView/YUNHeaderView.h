//
//  YUNHeaderView.h
//  YUNScrollHeaderView
//
//  Created by Orange on 4/26/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUNHeaderViewProtocol.h"

@interface YUNHeaderView : UIView <YUNHeaderViewProtocol>

@property (nonatomic, assign) CGRect originFrame;

@property (nonatomic, assign) YUNHeaderViewHierarchy hierarchy;

@end
