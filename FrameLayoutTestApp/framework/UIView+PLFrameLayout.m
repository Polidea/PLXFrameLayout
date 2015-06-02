//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import "UIView+PLFrameLayout.h"

@implementation UIView (PLFrameLayout)

- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}

- (void)setMinY:(CGFloat)minY {
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

#pragma mark - Dimensions

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    self.size = CGSizeMake(width, self.height);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    self.size = CGSizeMake(self.width, height);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - Batch Align

- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings {
    return [self alignViewsVerticallyCentering:viewsAndSpacings];
}

- (CGFloat)alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings {
    return [self alignViewsVertically:viewsAndSpacings centeringWithMargin:0];
}

- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter {
    return [self alignViewsVertically:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeCenterX withMargin:spaceFromCenter];
}

- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute {
    CGFloat height = 0;
    NSNumber *previousSpacing = nil;
    UIView *previousView = nil;
    for (id viewOrSpacing in viewsAndSpacings) {
        __unused BOOL isView = [viewOrSpacing isKindOfClass:[UIView class]];
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(!isView || !isSpacing, @"Item must be a view or a number.");
        if (isSpacing) {
            previousSpacing = viewOrSpacing;
            continue;
        }
        UIView *view = viewOrSpacing;
        CGFloat margin = previousSpacing ? previousSpacing.floatValue : 0;
        if (!previousView && previousSpacing) {
            [view alignToSuperView:NSLayoutAttributeTop withMargin:margin];
        } else if (previousView) {
            [view placeUnder:previousView withMargin:margin];
        }
        height += margin + view.height;
        previousView = view;
        previousSpacing = nil;
        switch (attribute) {
            case NSLayoutAttributeLeft:
            case NSLayoutAttributeRight:
            case NSLayoutAttributeCenterX:
                [view alignTo:attribute ofView:self withMargin:marginFromAttribute];
                break;
            default:
                @throw [NSException exceptionWithName:@"PLLayoutUnsupportedAttributeException" reason:@"This attribute is not supported."
                                             userInfo:nil];
        }
    }
    return height;
}

- (CGFloat)alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter{
    return [self alignViewsHorizontally:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeCenterY withMargin:spaceFromCenter];
}

- (CGFloat)alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute{
    CGFloat width = 0;
    NSNumber *previousSpacing = nil;
    UIView *previousView = nil;
    for (id viewOrSpacing in viewsAndSpacings) {
        __unused BOOL isView = [viewOrSpacing isKindOfClass:[UIView class]];
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(!isView || !isSpacing, @"Item must be a view or a number.");
        if (isSpacing) {
            previousSpacing = viewOrSpacing;
            continue;
        }
        UIView *view = viewOrSpacing;
        CGFloat margin = previousSpacing ? previousSpacing.floatValue : 0;
        if (!previousView && previousSpacing) {
            [view alignToSuperView:NSLayoutAttributeLeft withMargin:margin];
        } else if (previousView) {
            [view placeOnRightOf:previousView withMargin:margin];
        }
        width += margin + view.width;
        previousView = view;
        previousSpacing = nil;
        switch (attribute) {
            case NSLayoutAttributeTop:
            case NSLayoutAttributeBottom:
            case NSLayoutAttributeCenterY:
                [view alignTo:attribute ofView:self withMargin:marginFromAttribute];
                break;
            default:
                @throw [NSException exceptionWithName:@"PLLayoutUnsupportedAttributeException" reason:@"This attribute is not supported."
                                             userInfo:nil];
        }
    }
    return width;
}

#pragma mark - Fill superviews

-(void)fillSuperViewVerticallyWithViews:(NSArray *)viewsAndSpacing expandableViews:(NSSet *)expandableViews{
    CGFloat allNonExpandableViewsHeight = 0;
    for (UIView *view in viewsAndSpacing) {
        allNonExpandableViewsHeight += [expandableViews containsObject:view] ? 0 : view.height; //expandable doesn't count
    }
    
    CGFloat freeVerticalSpace = CGRectGetHeight(self.bounds) - allNonExpandableViewsHeight;
    CGFloat heightForSingleExpandableView = freeVerticalSpace / (CGFloat)expandableViews.count;
    
    for(UIView *expandableView in expandableViews){
        expandableView.height = heightForSingleExpandableView;
    }
    
    [self alignViewsVertically:viewsAndSpacing];
}

-(void)fillSuperViewHorizontallyWithViews:(NSArray *)viewsAndSpacing expandableViews:(NSSet *)expandableViews{
    CGFloat allNonExpandableViewsWidth = 0;
    for (UIView *view in viewsAndSpacing) {
        allNonExpandableViewsWidth += [expandableViews containsObject:view] ? 0 : view.height; //expandable doesn't count
    }
    
    CGFloat freeHorizontalSpace = CGRectGetWidth(self.bounds) - allNonExpandableViewsWidth;
    CGFloat widthForSingleExpandableView = freeHorizontalSpace / (CGFloat)expandableViews.count;
    
    for(UIView *expandableView in expandableViews){
        expandableView.height = widthForSingleExpandableView;
    }
    
    [self alignViewsVertically:viewsAndSpacing];
}

#pragma mark - Arrange superviews

-(void)arrangeSubViewsVerticallyInSuperView:(NSArray *)subviews addLeadingAndTrailingSpaces:(BOOL)leadingAndTralingSpaces{
    CGFloat subviewsTotalHeight = 0;
    for (UIView *view in subviews) {
        subviewsTotalHeight += CGRectGetHeight(view.bounds);
    }
    
    CGFloat freeVerticalSpace = CGRectGetHeight(self.bounds) - subviewsTotalHeight;
    
    NSInteger numberOfSpacers = leadingAndTralingSpaces ? subviews.count-1 + 2 : subviews.count-1;
    CGFloat spacerHeight = freeVerticalSpace / numberOfSpacers;
    
    NSMutableArray *viewsAndSpacers = [[NSMutableArray alloc]init];

    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];

        BOOL isLastObject = idx==subviews.count-1;
        if (!isLastObject){
            [viewsAndSpacers addObject:@(spacerHeight)];
        }
    }];
    
    if(leadingAndTralingSpaces){
        [viewsAndSpacers insertObject:@(spacerHeight) atIndex:0];
        [viewsAndSpacers addObject:@(spacerHeight)];
    }

    [self alignViewsVertically:viewsAndSpacers];
}

-(void)arrangeSubViewsHorizontallyInSuperView:(NSArray *)subviews addLeadingAndTrailingSpaces:(BOOL)leadingAndTralingSpaces{
    CGFloat subviewsTotalWidth = 0;
    for (UIView *view in subviews) {
        subviewsTotalWidth += CGRectGetWidth(view.bounds);
    }
    
    CGFloat freeHorizontalSpace = CGRectGetWidth(self.bounds) - subviewsTotalWidth;
    
    NSInteger numberOfSpacers = leadingAndTralingSpaces ? subviews.count-1 + 2 : subviews.count-1;
    CGFloat spacerWidth = freeHorizontalSpace / numberOfSpacers;
    
    NSMutableArray *viewsAndSpacers = [[NSMutableArray alloc]init];
    
    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];
        
        BOOL isLastObject = idx==subviews.count-1;
        if (!isLastObject){
            [viewsAndSpacers addObject:@(spacerWidth)];
        }
    }];
    
    if(leadingAndTralingSpaces){
        [viewsAndSpacers insertObject:@(spacerWidth) atIndex:0];
        [viewsAndSpacers addObject:@(spacerWidth)];
    }

    [self alignViewsHorizontally:viewsAndSpacers additionallyAligningTo:NSLayoutAttributeCenterY withMargin:0];
}

#pragma mark - Edges

- (void)pinToSuperViewEdges {
    self.frame = self.superview.bounds;
}

- (void)pinToSuperViewEdgesWithInsets:(UIEdgeInsets)insets {
    [self pinToSuperViewHorizontalEdgesWithInsets:insets];
    [self pinToSuperViewVerticalEdgesWithInsets:insets];
}

- (void)pinToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets {
    [self pinToSuperViewEdge:NSLayoutAttributeTop withInset:insets.top];
    [self pinToSuperViewEdge:NSLayoutAttributeBottom withInset:insets.bottom];
}

- (void)pinToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets {
    [self pinToSuperViewEdge:NSLayoutAttributeLeft withInset:insets.left];
    [self pinToSuperViewEdge:NSLayoutAttributeRight withInset:insets.right];
}

- (void)pinToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset {
    CGRect frame = self.frame;
    switch (edge) {
        case NSLayoutAttributeLeft: {
            CGFloat xDelta = CGRectGetMinX(frame) + inset;
            frame.origin.x = 0 + inset;
            frame.size.width += xDelta;
            break;
        }
        case NSLayoutAttributeRight: {
            CGFloat superViewRightX = CGRectGetWidth(self.superview.bounds);
            CGFloat xDelta = superViewRightX - CGRectGetMaxX(frame);
            frame.size.width += xDelta - inset;
            break;
        }
        case NSLayoutAttributeTop: {
            CGFloat yDelta = CGRectGetMinY(frame) + inset;
            frame.origin.y = 0 + inset;
            frame.size.height += yDelta;
            break;
        }
        case NSLayoutAttributeBottom: {
            CGFloat superViewBottomY = CGRectGetHeight(self.superview.bounds);
            CGFloat yDelta = superViewBottomY - CGRectGetMaxY(frame);
            frame.size.height += yDelta - inset;
            break;
        }
        default:
            break;
    }
    self.frame = frame;
}

#pragma mark - Center

- (void)alignToCenterXOfView:(UIView *)view {
    [self alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)alignToCenterYOfView:(UIView *)view {
    [self alignTo:NSLayoutAttributeCenterY ofView:view withMargin:0];
}

- (void)centerXInSuperView {
    [self alignToSuperView:NSLayoutAttributeCenterX withMargin:0];
}

- (void)centerYInSuperView {
    [self alignToSuperView:NSLayoutAttributeCenterY withMargin:0];
}

#pragma mark - Above

- (void)placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self placeAbove:view withMargin:margin];
    [self alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self placeAbove:view withMargin:margin];
    [self alignTo:NSLayoutAttributeLeft ofView:view withMargin:0];
}

- (void)placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self placeAbove:view withMargin:margin];
    [self alignTo:NSLayoutAttributeRight ofView:view withMargin:0];
}

#pragma mark - Under

- (void)placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self placeUnder:view withMargin:margin];
    [self alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self placeUnder:view withMargin:margin];
    [self alignTo:NSLayoutAttributeLeft ofView:view withMargin:0];
}

- (void)placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self placeUnder:view withMargin:margin];
    [self alignTo:NSLayoutAttributeRight ofView:view withMargin:0];
}

#pragma mark - Core

- (void)placeUnder:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(view.frame) + margin;
    self.frame = frame;
}

- (void)placeAbove:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMinY(view.bounds) - CGRectGetHeight(frame) - margin;
    self.frame = frame;
}

- (void)placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetMinX(view.frame) - CGRectGetWidth(frame) + margin;
    self.frame = frame;
}

- (void)placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) + margin;
    self.frame = frame;
}

- (void)alignToSuperView:(NSLayoutAttribute)edgeAttribute withMargin:(CGFloat)margin {
    [self alignTo:edgeAttribute ofView:self.superview withMargin:margin];
}

- (void)alignTo:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    CGRect otherBounds;
    if ([view isEqual:self.superview]) {
        otherBounds = view.bounds;
    } else {
        otherBounds = view.frame;
    }
    switch (edgeAttribute) {
        case NSLayoutAttributeLeft:
            frame.origin.x = CGRectGetMinX(otherBounds) + margin;
            break;
        case NSLayoutAttributeRight:
            frame.origin.x = CGRectGetMaxX(otherBounds) - CGRectGetWidth(frame) - margin;
            break;
        case NSLayoutAttributeTop:
            frame.origin.y = CGRectGetMinY(otherBounds) + margin;
            break;
        case NSLayoutAttributeBottom:
            frame.origin.y = CGRectGetMaxY(otherBounds) - CGRectGetHeight(frame) - margin;
            break;
        case NSLayoutAttributeCenterX:
            frame.origin.x = CGRectGetMidX(otherBounds) - CGRectGetWidth(frame) * 0.5f + margin;
            break;
        case NSLayoutAttributeCenterY:
            frame.origin.y = CGRectGetMidY(otherBounds) - CGRectGetHeight(frame) * 0.5f + margin;
            break;
        default:
            @throw [NSException exceptionWithName:@"PLLayoutUnsupportedAttributeException" reason:@"This attribute is not supported."
                                         userInfo:nil];
    }
    self.frame = frame;
}

#pragma mark - Helpers

- (void)sizeToFitSubviews {
    for (UIView *subview in self.subviews) {
        [subview sizeToFit];
    }
}

@end
