//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import "UIView+PLXFrameLayout.h"

static NSString *const PLXFrameLayoutNotSupportedAttributeExceptionName = @"PLLayoutUnsupportedAttributeException";
static NSString *const PLXFrameLayoutNotSupportedAttributeExceptionReason = @"This attribute is not supported.";

@implementation UIView (PLXFrameLayout)

#pragma mark - MinY

- (CGFloat)pl_minY {
    return CGRectGetMinY(self.frame);
}

- (void)pl_setMinY:(CGFloat)minY {
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}

#pragma mark - MidY

- (CGFloat)pl_midY {
    return CGRectGetMidY(self.frame);
}

- (void)pl_setMidY:(CGFloat)midY {
    CGRect frame = self.frame;
    frame.origin.y = midY - frame.size.height * 0.5f;
    self.frame = frame;
}

#pragma mark - MaxY

- (CGFloat)pl_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)pl_setMaxY:(CGFloat)maxY {
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

#pragma mark - MinX

- (CGFloat)pl_minX {
    return CGRectGetMinX(self.frame);
}

- (void)pl_setMinX:(CGFloat)minX {
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
}

#pragma mark - MidX

- (CGFloat)pl_midX {
    return CGRectGetMidX(self.frame);
}

- (void)pl_setMidX:(CGFloat)midX {
    CGRect frame = self.frame;
    frame.origin.x = midX - frame.size.width * 0.5f;
    self.frame = frame;
}

#pragma mark - MaxX

- (CGFloat)pl_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)pl_setMaxX:(CGFloat)maxX {
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

#pragma mark - Dimensions

- (CGFloat)pl_width {
    return self.frame.size.width;
}

- (void)pl_setWidth:(CGFloat)pl_width {
    self.pl_size = CGSizeMake(pl_width, self.pl_height);
}

- (CGFloat)pl_height {
    return self.frame.size.height;
}

- (void)pl_setHeight:(CGFloat)height {
    self.pl_size = CGSizeMake(self.pl_width, height);
}

- (CGSize)pl_size {
    return self.frame.size;
}

- (void)pl_setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

#pragma mark - Batch Align

#pragma mark - Vertical

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings {
    return [self pl_alignViewsVertically:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeNotAnAttribute withMargin:0];
}

- (CGFloat)pl_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings {
    return [self pl_alignViewsVertically:viewsAndSpacings centeringWithMargin:0];
}

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter {
    return [self pl_alignViewsVertically:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeCenterX withMargin:spaceFromCenter];
}

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute {
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
        if (view.isHidden) {
            continue;
        }
        CGFloat margin = previousSpacing ? previousSpacing.floatValue : 0;
        if (!previousView && previousSpacing) {
            [view pl_alignToSuperView:NSLayoutAttributeTop withMargin:margin];
        } else if (previousView) {
            [view pl_placeUnder:previousView withMargin:margin];
        }
        height += margin + view.pl_height;
        previousView = view;
        previousSpacing = nil;
        switch (attribute) {
            case NSLayoutAttributeLeft:
            case NSLayoutAttributeRight:
            case NSLayoutAttributeCenterX:
                [view pl_alignTo:attribute ofView:self withMargin:marginFromAttribute];
                break;
            case NSLayoutAttributeNotAnAttribute:
                break;
            default:
                @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                               reason:PLXFrameLayoutNotSupportedAttributeExceptionReason
                                             userInfo:nil];
        }
    }
    return height;
}

#pragma mark - Horizontal

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings {
    return [self pl_alignViewsHorizontally:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeNotAnAttribute withMargin:0];
}

- (CGFloat)pl_alignViewsHorizontallyCentering:(NSArray *)viewsAndSpacings {
    return [self pl_alignViewsHorizontally:viewsAndSpacings centeringWithMargin:0];
}

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter {
    return [self pl_alignViewsHorizontally:viewsAndSpacings additionallyAligningTo:NSLayoutAttributeCenterY withMargin:spaceFromCenter];
}

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute {
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
        if (view.isHidden) {
            continue;
        }
        CGFloat margin = previousSpacing ? previousSpacing.floatValue : 0;
        if (!previousView && previousSpacing) {
            [view pl_alignToSuperView:NSLayoutAttributeLeft withMargin:margin];
        } else if (previousView) {
            [view pl_placeOnRightOf:previousView withMargin:margin];
        }
        width += margin + view.pl_width;
        previousView = view;
        previousSpacing = nil;
        switch (attribute) {
            case NSLayoutAttributeTop:
            case NSLayoutAttributeBottom:
            case NSLayoutAttributeCenterY:
                [view pl_alignTo:attribute ofView:self withMargin:marginFromAttribute];
                break;
            case NSLayoutAttributeNotAnAttribute:
                break;
            default:
                @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                               reason:PLXFrameLayoutNotSupportedAttributeExceptionReason
                                             userInfo:nil];
        }
    }
    return width;
}

#pragma mark - Fill superviews

- (void)pl_fillSuperViewVertically:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews {
    __block UIView *firstView = nil;
    __block NSNumber *firstSpacing = nil;
    __block CGFloat allNonExpandableViewsHeight = 0;

    [viewsAndSpacings enumerateObjectsUsingBlock:^(id viewOrSpacing, NSUInteger idx, BOOL *stop) {
        BOOL isView = [viewOrSpacing isKindOfClass:[UIView class]];
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(!isView || !isSpacing, @"Item must be a view or a number.");
        if (isSpacing) {
            allNonExpandableViewsHeight += [viewOrSpacing floatValue];
            if (idx == 0) {
                firstSpacing = [viewOrSpacing copy];
            }
        } else {
            BOOL isExpandableView = [expandableViews containsObject:viewOrSpacing];
            allNonExpandableViewsHeight += isExpandableView ? 0 : [(UIView *) viewOrSpacing pl_height];
            if (!firstView) {
                firstView = viewOrSpacing;
            }
        }
    }];

    CGFloat freeVerticalSpace = CGRectGetHeight(self.bounds) - allNonExpandableViewsHeight;
    CGFloat heightForSingleExpandableView = freeVerticalSpace / (CGFloat) expandableViews.count;

    for (UIView *expandableView in expandableViews) {
        expandableView.pl_height = heightForSingleExpandableView;
    }

    [firstView pl_alignTo:NSLayoutAttributeTop ofView:self withMargin:firstSpacing.floatValue];
    [self pl_alignViewsVertically:viewsAndSpacings];
}

- (void)pl_fillSuperViewHorizontally:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews {
    __block UIView *firstView = nil;
    __block NSNumber *firstSpacing = nil;
    __block CGFloat allNonExpandableViewsWidth = 0;

    [viewsAndSpacings enumerateObjectsUsingBlock:^(id viewOrSpacing, NSUInteger idx, BOOL *stop) {
        BOOL isView = [viewOrSpacing isKindOfClass:[UIView class]];
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(!isView || !isSpacing, @"Item must be a view or a number.");
        if (isSpacing) {
            allNonExpandableViewsWidth += [viewOrSpacing floatValue];
            if (idx == 0) {
                firstSpacing = [viewOrSpacing copy];
            }
        } else {
            BOOL isExpandableView = [expandableViews containsObject:viewOrSpacing];
            allNonExpandableViewsWidth += isExpandableView ? 0 : [(UIView *) viewOrSpacing pl_width];
            if (!firstView) {
                firstView = viewOrSpacing;
            }
        }
    }];

    CGFloat freeHorizontalSpace = CGRectGetWidth(self.bounds) - allNonExpandableViewsWidth;
    CGFloat widthForSingleExpandableView = freeHorizontalSpace / (CGFloat) expandableViews.count;

    for (UIView *expandableView in expandableViews) {
        expandableView.pl_width = widthForSingleExpandableView;
    }

    [firstView pl_alignTo:NSLayoutAttributeLeft ofView:self withMargin:firstSpacing.floatValue];
    [self pl_alignViewsHorizontally:viewsAndSpacings centeringWithMargin:0];
}

#pragma mark - Arrange superviews

- (void)pl_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins {
    CGFloat subviewsTotalHeight = 0;
    for (UIView *view in subviews) {
        subviewsTotalHeight += CGRectGetHeight(view.bounds);
    }

    CGFloat freeVerticalSpace = CGRectGetHeight(self.bounds) - subviewsTotalHeight;

    NSInteger numberOfSpacers = shouldAddTopAndBottomMargins ? subviews.count - 1 + 2 : subviews.count - 1;
    CGFloat spacerHeight = freeVerticalSpace / numberOfSpacers;

    NSMutableArray *viewsAndSpacers = [[NSMutableArray alloc] init];

    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];

        BOOL isLastObject = idx == subviews.count - 1;
        if (!isLastObject) {
            [viewsAndSpacers addObject:@(spacerHeight)];
        }
    }];

    if (shouldAddTopAndBottomMargins) {
        [viewsAndSpacers insertObject:@(spacerHeight) atIndex:0];
        [viewsAndSpacers addObject:@(spacerHeight)];
    }

    UIView *firstSubview = subviews.firstObject;
    [firstSubview pl_alignTo:NSLayoutAttributeTop ofView:self withMargin:0];

    [self pl_alignViewsVertically:viewsAndSpacers additionallyAligningTo:NSLayoutAttributeCenterX withMargin:0];
}

- (void)pl_distributeSubviewsHorizontallyInSuperView:(NSArray *)subviews withLeftAndRightMargin:(BOOL)shouldAddLeftAndRightMargin {
    CGFloat subviewsTotalWidth = 0;
    for (UIView *view in subviews) {
        subviewsTotalWidth += CGRectGetWidth(view.bounds);
    }

    CGFloat freeHorizontalSpace = CGRectGetWidth(self.bounds) - subviewsTotalWidth;

    NSInteger numberOfSpacers = shouldAddLeftAndRightMargin ? subviews.count - 1 + 2 : subviews.count - 1;
    CGFloat spacerWidth = freeHorizontalSpace / numberOfSpacers;

    NSMutableArray *viewsAndSpacers = [[NSMutableArray alloc] init];

    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];

        BOOL isLastObject = idx == subviews.count - 1;
        if (!isLastObject) {
            [viewsAndSpacers addObject:@(spacerWidth)];
        }
    }];

    if (shouldAddLeftAndRightMargin) {
        [viewsAndSpacers insertObject:@(spacerWidth) atIndex:0];
        [viewsAndSpacers addObject:@(spacerWidth)];
    }

    UIView *firstSubview = subviews.firstObject;
    [firstSubview pl_alignTo:NSLayoutAttributeLeft ofView:self withMargin:0];

    [self pl_alignViewsHorizontally:viewsAndSpacers];
}

#pragma mark - Edges

- (void)pl_expandToSuperViewEdges {
    self.frame = self.superview.bounds;
}

- (void)pl_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets {
    [self pl_expandToSuperViewHorizontalEdgesWithInsets:insets];
    [self pl_expandToSuperViewVerticalEdgesWithInsets:insets];
}

- (void)pl_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets {
    [self pl_expandToSuperViewEdge:NSLayoutAttributeTop withInset:insets.top];
    [self pl_expandToSuperViewEdge:NSLayoutAttributeBottom withInset:insets.bottom];
}

- (void)pl_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets {
    [self pl_expandToSuperViewEdge:NSLayoutAttributeLeft withInset:insets.left];
    [self pl_expandToSuperViewEdge:NSLayoutAttributeRight withInset:insets.right];
}

- (void)pl_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset {
    CGRect frame = self.frame;
    switch (edge) {
        case NSLayoutAttributeLeft: {
            CGFloat xDelta = CGRectGetMinX(frame) - inset;
            frame.origin.x = 0 + inset;
            if (frame.size.width >= fabs(xDelta)) {
                frame.size.width += xDelta;
            }
            break;
        }
        case NSLayoutAttributeRight: {
            CGFloat superViewRightX = CGRectGetWidth(self.superview.bounds);
            CGFloat xDelta = superViewRightX - CGRectGetMaxX(frame);
            frame.size.width += xDelta - inset;
            break;
        }
        case NSLayoutAttributeTop: {
            CGFloat yDelta = CGRectGetMinY(frame) - inset;
            frame.origin.y = 0 + inset;
            if (frame.size.height >= fabs(yDelta)) {
                frame.size.height += yDelta;
            }
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

#pragma mark - Relative

- (void)pl_alignToCenterOfView:(UIView *)view {
    [self pl_alignToCenterXOfView:view];
    [self pl_alignToCenterYOfView:view];
}

- (void)pl_alignToCenterXOfView:(UIView *)view {
    [self pl_alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)pl_alignToCenterYOfView:(UIView *)view {
    [self pl_alignTo:NSLayoutAttributeCenterY ofView:view withMargin:0];
}

#pragma mark - Absolute

- (void)pl_centerInSuperView {
    [self pl_centerXInSuperView];
    [self pl_centerYInSuperView];
}

- (void)pl_centerXInSuperView {
    [self pl_alignToSuperView:NSLayoutAttributeCenterX withMargin:0];
}

- (void)pl_centerYInSuperView {
    [self pl_alignToSuperView:NSLayoutAttributeCenterY withMargin:0];
}

#pragma mark - Above

- (void)pl_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)pl_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeLeft ofView:view withMargin:0];
}

- (void)pl_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeRight ofView:view withMargin:0];
}

#pragma mark - Under

- (void)pl_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeCenterX ofView:view withMargin:0];
}

- (void)pl_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeLeft ofView:view withMargin:0];
}

- (void)pl_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignTo:NSLayoutAttributeRight ofView:view withMargin:0];
}

#pragma mark - Core

- (void)pl_placeUnder:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMaxY(view.frame) + margin;
    self.frame = frame;
}

- (void)pl_placeAbove:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.y = CGRectGetMinY(view.frame) - CGRectGetHeight(frame) - margin;
    self.frame = frame;
}

- (void)pl_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetMinX(view.frame) - CGRectGetWidth(frame) + margin;
    self.frame = frame;
}

- (void)pl_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin {
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) + margin;
    self.frame = frame;
}

- (void)pl_alignToSuperView:(NSLayoutAttribute)edgeAttribute withMargin:(CGFloat)margin {
    [self pl_alignTo:edgeAttribute ofView:self.superview withMargin:margin];
}

- (void)pl_alignTo:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withMargin:(CGFloat)margin {
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
            @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                           reason:PLXFrameLayoutNotSupportedAttributeExceptionReason
                                         userInfo:nil];
    }
    self.frame = frame;
}

#pragma mark - Helpers

- (void)pl_sizeToFitSubviews {
    for (UIView *subview in self.subviews) {
        [subview sizeToFit];
    }
}

#pragma mark - Deprecated

- (void)pl_fillSuperViewVerticallyWithViews:(NSArray *)views expandableViews:(NSSet *)expandableViews {
    [self pl_fillSuperViewVertically:views expandableViews:expandableViews.allObjects];
}

- (void)pl_fillSuperViewHorizontallyWithViews:(NSArray *)views expandableViews:(NSSet *)expandableViews {
    [self pl_fillSuperViewHorizontally:views expandableViews:expandableViews.allObjects];
}

- (void)pl_arrangeSubViewsVerticallyInSuperView:(NSArray *)subviews addTopAndBottomSpaces:(BOOL)topAndBottomSpaces {
    [self pl_distributeSubviewsVerticallyInSuperView:subviews withTopAndBottomMargin:topAndBottomSpaces];
}

- (void)pl_arrangeSubViewsHorizontallyInSuperView:(NSArray *)subviews addLeadingAndTrailingSpaces:(BOOL)leadingAndTrailingSpaces {
    [self pl_distributeSubviewsHorizontallyInSuperView:subviews withLeftAndRightMargin:leadingAndTrailingSpaces];
}

@end
