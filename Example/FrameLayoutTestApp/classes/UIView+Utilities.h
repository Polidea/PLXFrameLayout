//
// Created by Maciej Oczko on 03/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Utilities)
+ (NSArray *)viewsAlignmentArrayWithCapacity:(NSUInteger)count withBuildBlock:(UIView *(^)())buildBlock;

+ (NSArray *)viewsAlignmentArrayWithCapacity:(NSUInteger)count withBuildBlock:(UIView *(^)())buildBlock defaultSpacing:(CGFloat)spacing;

- (void)addSubviews:(NSArray *)subviews;

@end
