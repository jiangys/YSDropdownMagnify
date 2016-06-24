//
//  UINavigationBar+Transparent.m
//  TransparentNavigationBar
//
//  Created by Michael on 15/11/20.
//  Copyright © 2015年 com.51fanxing. All rights reserved.
//

#import "UINavigationBar+Transparent.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Transparent)

static char KCustomViewKey;

- (void)ys_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.customView)
    {
        [self setBackgroundImage:[UIImage new] forBarMetrics:(UIBarMetricsDefault)];
        //[self setShadowImage:[[UIImage alloc] init]];
        
        self.customView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + 20)];
        self.customView.userInteractionEnabled = NO;
        self.customView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.customView atIndex:0];
    }
    self.customView.backgroundColor = backgroundColor;
}

- (void)ys_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
    
    //  when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)ys_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:nil];
    
    [self.customView removeFromSuperview];
    self.customView = nil;
}


#pragma mark - get和set方法
- (UIView *)customView
{
    return objc_getAssociatedObject(self, &KCustomViewKey);
}

- (void)setCustomView:(UIView *)customView
{
    objc_setAssociatedObject(self, &KCustomViewKey, customView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
