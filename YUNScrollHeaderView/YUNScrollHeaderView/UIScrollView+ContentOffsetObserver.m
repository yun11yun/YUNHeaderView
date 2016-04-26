//
//  UIScrollView+ContentOffsetObserver.m
//  YUNScrollHeaderView
//
//  Created by Orange on 4/22/16.
//  Copyright © 2016 Tordian. All rights reserved.
//

#import "UIScrollView+ContentOffsetObserver.h"
#import <objc/runtime.h>
#import "UIScrollViewContentOffsetObserver.h"

@implementation UIScrollView (ContentOffsetObserver)

#pragma mark - MethodSwizzling
+ (void)load
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL deallocOriginSEL = NSSelectorFromString(@"dealloc");
        SEL deallocNewSEL = @selector(xjj_scrollViewObserver_dealloc);
        [self swizzlOriginSEL:deallocOriginSEL newSEL:deallocNewSEL];
        
    });
    
}

- (void)xjj_scrollViewObserver_dealloc
{
    
    self.contentOffsetObserver = nil;
    
    [self xjj_scrollViewObserver_dealloc];
}

+ (void)swizzlOriginSEL:(SEL)originSEL newSEL:(SEL)newSEL
{
    Method originMethod = class_getInstanceMethod(self.class, originSEL);
    Method newMethod = class_getInstanceMethod(self.class, newSEL);
    
    if (class_addMethod(self.class, originSEL, method_getImplementation(newMethod), method_getTypeEncoding(originMethod))) {
        class_replaceMethod(self.class, newSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }
    else
    {
        method_exchangeImplementations(originMethod, newMethod);
    }
}

#pragma mark - Setter & Getter
- (void)setContentOffsetObserver:(UIScrollViewContentOffsetObserver *)contentOffsetObserver
{
    if (objc_getAssociatedObject(self, @selector(contentOffsetObserver))) {
        [self removeObserver:self.contentOffsetObserver forKeyPath:ContentOffsetKeyPath];
    }
    
    if (contentOffsetObserver) {
        [self addObserver:contentOffsetObserver forKeyPath:ContentOffsetKeyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    }
    
    objc_setAssociatedObject(self, @selector(contentOffsetObserver), contentOffsetObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIScrollViewContentOffsetObserver *)contentOffsetObserver
{
    
    if (!objc_getAssociatedObject(self, _cmd)) {
        self.contentOffsetObserver = [[UIScrollViewContentOffsetObserver alloc] init];
    }
    
    return objc_getAssociatedObject(self, _cmd);
}

@end
