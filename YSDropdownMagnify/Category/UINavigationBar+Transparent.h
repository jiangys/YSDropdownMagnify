//
//  UINavigationBar+Transparent.h
//  TransparentNavigationBar
//
//  Created by Michael on 15/11/20.
//  Copyright © 2015年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Transparent)

// 如想实现导航颜色的渐变 ，则translucent 属性不可为no，系统默认为yes
- (void)ys_setBackgroundColor:(UIColor *)backgroundColor;
- (void)ys_setElementsAlpha:(CGFloat)alpha;
- (void)ys_reset;

@end
