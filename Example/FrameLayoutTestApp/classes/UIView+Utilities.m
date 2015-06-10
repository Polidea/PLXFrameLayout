//
// Created by Maciej Oczko on 03/06/15.
// Copyright (c) 2015 Polidea. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

+ (NSArray *)viewsAlignmentArrayWithCapacity:(NSUInteger)count withBuildBlock:(UIView *(^)())buildBlock {
    return [self viewsAlignmentArrayWithCapacity:count withBuildBlock:buildBlock defaultSpacing:HUGE_VALF];
}

+ (NSArray *)viewsAlignmentArrayWithCapacity:(NSUInteger)count withBuildBlock:(UIView *(^)())buildBlock defaultSpacing:(CGFloat)spacing {
    NSParameterAssert(buildBlock != nil);
    NSMutableArray *alignments = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSUInteger i = 0; i < count; ++i) {
        UIView *view = buildBlock();
        if (spacing == HUGE_VALF) {
            [alignments addObject:view];
        } else {
            [alignments addObjectsFromArray:@[@(spacing), view]];
        }
    }
    return alignments;
}

- (void)addSubviews:(NSArray *)subviews {
    for (UIView *subview in subviews){
        NSAssert([subview isKindOfClass:[UIView class]], @"Subview is not UIView subclas");
        [self addSubview:subview];
    }
}

@end
