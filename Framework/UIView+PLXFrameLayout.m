//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import "UIView+PLXFrameLayout.h"
#import <objc/runtime.h>
#import <objc/message.h>

static NSString *const PLXFrameLayoutAttributesNotMatchExceptionName = @"PLXFrameLayoutAttributesNotMatchExceptionName";
static NSString *const PLXFrameLayoutNotSupportedAttributeExceptionName = @"PLXFrameLayoutNotSupportedAttributeExceptionName";
static NSString *const PLXFrameLayoutNotSupportedAttributeExceptionReasonFormat = @"Attribute '%@' is not supported.";

NSString *PLX_NSStringFromLayoutAttributes(NSLayoutAttribute attribute);
CGFloat (*CGFloatMsgSend)(id, SEL) = (CGFloat (*)(id, SEL)) objc_msgSend;
void (*setCGFloatMsgSend)(id, SEL, CGFloat) = (void (*)(id, SEL, CGFloat)) objc_msgSend;

static NSDictionary *horizontalAttributeGetters = nil;
static NSDictionary *verticalAttributeGetters = nil;
static NSDictionary *dimensionAttributeGetters = nil;
static NSDictionary *horizontalAttributeSetters = nil;
static NSDictionary *verticalAttributeSetters = nil;
static NSDictionary *dimensionAttributeSetters = nil;
static NSArray *getterAttributes = nil;
static NSArray *setterAttributes = nil;

@implementation UIView (PLXFrameLayout)

+ (void)load {
    [super load];

    horizontalAttributeGetters = @{
            @(NSLayoutAttributeLeft) : NSStringFromSelector(@selector(pl_minX)),
            @(NSLayoutAttributeCenterX) : NSStringFromSelector(@selector(pl_midX)),
            @(NSLayoutAttributeRight) : NSStringFromSelector(@selector(pl_maxX))
    };
    verticalAttributeGetters = @{
            @(NSLayoutAttributeTop) : NSStringFromSelector(@selector(pl_minY)),
            @(NSLayoutAttributeCenterY) : NSStringFromSelector(@selector(pl_midY)),
            @(NSLayoutAttributeBottom) : NSStringFromSelector(@selector(pl_maxY))
    };
    dimensionAttributeGetters = @{
            @(NSLayoutAttributeWidth) : NSStringFromSelector(@selector(pl_width)),
            @(NSLayoutAttributeHeight) : NSStringFromSelector(@selector(pl_height))
    };

    horizontalAttributeSetters = [self settersMapWithGetters:horizontalAttributeGetters];
    verticalAttributeSetters = [self settersMapWithGetters:verticalAttributeGetters];
    dimensionAttributeSetters = [self settersMapWithGetters:dimensionAttributeGetters];

    getterAttributes = @[horizontalAttributeGetters, verticalAttributeGetters, dimensionAttributeGetters];
    setterAttributes = @[horizontalAttributeSetters, verticalAttributeSetters, dimensionAttributeSetters];
}

+ (NSDictionary *)settersMapWithGetters:(NSDictionary *)attributeGetters {
    NSMutableDictionary *attributeSetters = [NSMutableDictionary dictionary];
    [attributeGetters enumerateKeysAndObjectsUsingBlock:^(NSNumber *attributeType, NSString *getterName, BOOL *stop) {
        objc_property_t getterProperty = class_getProperty([self class], [getterName UTF8String]);
        NSString *propertyAttributes = [NSString stringWithCString:property_getAttributes(getterProperty) encoding:NSUTF8StringEncoding];
        NSArray *propertyAttributeComponents = [propertyAttributes componentsSeparatedByString:@","];
        NSString *setterAttributes = [[propertyAttributeComponents filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self BEGINSWITH 'S'"]] firstObject];
        NSString *setterName = [setterAttributes substringWithRange:NSMakeRange(1, setterAttributes.length - 1)];
        attributeSetters[attributeType] = setterName;
    }];
    return attributeSetters;
}

#pragma mark - MinY

- (CGFloat)pl_minY {
    return CGRectGetMinY(self.pl_frame);
}

- (void)pl_setMinY:(CGFloat)minY {
    CGRect frame = self.pl_frame;
    frame.origin.y = minY;
    self.pl_frame = frame;
}

#pragma mark - MidY

- (CGFloat)pl_midY {
    return CGRectGetMidY(self.pl_frame);
}

- (void)pl_setMidY:(CGFloat)midY {
    CGRect frame = self.pl_frame;
    frame.origin.y = midY - frame.size.height * 0.5f;
    self.pl_frame = frame;
}

#pragma mark - MaxY

- (CGFloat)pl_maxY {
    return CGRectGetMaxY(self.pl_frame);
}

- (void)pl_setMaxY:(CGFloat)maxY {
    CGRect frame = self.pl_frame;
    frame.origin.y = maxY - frame.size.height;
    self.pl_frame = frame;
}

#pragma mark - MinX

- (CGFloat)pl_minX {
    return CGRectGetMinX(self.pl_frame);
}

- (void)pl_setMinX:(CGFloat)minX {
    CGRect frame = self.pl_frame;
    frame.origin.x = minX;
    self.pl_frame = frame;
}

#pragma mark - MidX

- (CGFloat)pl_midX {
    return CGRectGetMidX(self.pl_frame);
}

- (void)pl_setMidX:(CGFloat)midX {
    CGRect frame = self.pl_frame;
    frame.origin.x = midX - frame.size.width * 0.5f;
    self.pl_frame = frame;
}

#pragma mark - MaxX

- (CGFloat)pl_maxX {
    return CGRectGetMaxX(self.pl_frame);
}

- (void)pl_setMaxX:(CGFloat)maxX {
    CGRect frame = self.pl_frame;
    frame.origin.x = maxX - frame.size.width;
    self.pl_frame = frame;
}

#pragma mark - Dimensions

- (CGFloat)pl_width {
    return self.pl_frame.size.width;
}

- (void)pl_setWidth:(CGFloat)pl_width {
    self.pl_size = CGSizeMake(pl_width, self.pl_height);
}

- (CGFloat)pl_height {
    return self.pl_frame.size.height;
}

- (void)pl_setHeight:(CGFloat)height {
    self.pl_size = CGSizeMake(self.pl_width, height);
}

- (CGSize)pl_size {
    return self.pl_frame.size;
}

- (void)pl_setSize:(CGSize)size {
    CGRect frame = self.pl_frame;
    frame.size = size;
    self.pl_frame = frame;
}

- (CGRect)pl_frame {
    return self.pl_shouldUseBoundsInsteadOfFrame ? self.bounds : self.frame;
}

- (void)pl_setFrame:(CGRect)rect {
    if (self.pl_shouldUseBoundsInsteadOfFrame) {
        self.bounds = rect;
    } else {
        self.frame = rect;
    }
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
    marginFromAttribute = (attribute == NSLayoutAttributeRight ? -1 : 1) * marginFromAttribute;
    CGFloat height = 0;
    NSNumber *previousSpacing = nil;
    UIView *previousView = nil;
    for (id viewOrSpacing in viewsAndSpacings) {
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(![viewOrSpacing isKindOfClass:[UIView class]] || !isSpacing, @"Item must be a view or a number.");
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
            [view pl_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:margin];
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
                [view pl_alignToAttribute:attribute ofView:self withOffset:marginFromAttribute];
                break;
            case NSLayoutAttributeNotAnAttribute:
                break;
            default:
                @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                               reason:[NSString stringWithFormat:PLXFrameLayoutNotSupportedAttributeExceptionReasonFormat,
                                                                                 PLX_NSStringFromLayoutAttributes(attribute)]
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
    marginFromAttribute = (attribute == NSLayoutAttributeBottom ? -1 : 1) * marginFromAttribute;
    CGFloat width = 0;
    NSNumber *previousSpacing = nil;
    UIView *previousView = nil;
    for (id viewOrSpacing in viewsAndSpacings) {
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(![viewOrSpacing isKindOfClass:[UIView class]] || !isSpacing, @"Item must be a view or a number.");
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
            [view pl_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:margin];
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
                [view pl_alignToAttribute:attribute ofView:self withOffset:marginFromAttribute];
                break;
            case NSLayoutAttributeNotAnAttribute:
                break;
            default:
                @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                               reason:[NSString stringWithFormat:PLXFrameLayoutNotSupportedAttributeExceptionReasonFormat,
                                                                                 PLX_NSStringFromLayoutAttributes(attribute)]
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
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(![viewOrSpacing isKindOfClass:[UIView class]] || !isSpacing, @"Item must be a view or a number.");
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

    [firstView pl_alignToAttribute:NSLayoutAttributeTop ofView:self withOffset:firstSpacing.floatValue];
    [self pl_alignViewsVertically:viewsAndSpacings];
}

- (void)pl_fillSuperViewHorizontally:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews {
    __block UIView *firstView = nil;
    __block NSNumber *firstSpacing = nil;
    __block CGFloat allNonExpandableViewsWidth = 0;

    [viewsAndSpacings enumerateObjectsUsingBlock:^(id viewOrSpacing, NSUInteger idx, BOOL *stop) {
        BOOL isSpacing = [viewOrSpacing isKindOfClass:[NSNumber class]];
        NSAssert(![viewOrSpacing isKindOfClass:[UIView class]] || !isSpacing, @"Item must be a view or a number.");
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

    [firstView pl_alignToAttribute:NSLayoutAttributeLeft ofView:self withOffset:firstSpacing.floatValue];
    [self pl_alignViewsHorizontally:viewsAndSpacings centeringWithMargin:0];
}

#pragma mark - Arrange superviews

- (void)pl_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins {
    NSUInteger lastSubviewsIndex = subviews.count - 1;
    CGFloat subviewsTotalHeight = 0;
    for (UIView *view in subviews) {
        subviewsTotalHeight += view.pl_height;
    }

    CGFloat freeVerticalSpace = CGRectGetHeight(self.bounds) - subviewsTotalHeight;

    NSInteger numberOfSpacers = lastSubviewsIndex + (shouldAddTopAndBottomMargins ? 2 : 0);
    CGFloat spacerHeight = freeVerticalSpace / numberOfSpacers;

    NSMutableArray *viewsAndSpacers = [NSMutableArray array];

    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];

        BOOL isLastObject = idx == lastSubviewsIndex;
        if (!isLastObject) {
            [viewsAndSpacers addObject:@(spacerHeight)];
        }
    }];

    if (shouldAddTopAndBottomMargins) {
        [viewsAndSpacers insertObject:@(spacerHeight) atIndex:0];
        [viewsAndSpacers addObject:@(spacerHeight)];
    }

    UIView *firstSubview = subviews.firstObject;
    [firstSubview pl_alignToAttribute:NSLayoutAttributeTop ofView:self withOffset:0];

    [self pl_alignViewsVertically:viewsAndSpacers];
}

- (void)pl_distributeSubviewsHorizontallyInSuperView:(NSArray *)subviews withLeftAndRightMargin:(BOOL)shouldAddLeftAndRightMargin {
    NSUInteger lastSubviewIndex = subviews.count - 1;
    CGFloat subviewsTotalWidth = 0;
    for (UIView *view in subviews) {
        subviewsTotalWidth += view.pl_width;
    }

    CGFloat freeHorizontalSpace = CGRectGetWidth(self.bounds) - subviewsTotalWidth;

    NSInteger numberOfSpacers = lastSubviewIndex + (shouldAddLeftAndRightMargin ? 2 : 0);
    CGFloat spacerWidth = freeHorizontalSpace / numberOfSpacers;

    NSMutableArray *viewsAndSpacers = [NSMutableArray array];

    [subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        [viewsAndSpacers addObject:subview];

        BOOL isLastObject = idx == lastSubviewIndex;
        if (!isLastObject) {
            [viewsAndSpacers addObject:@(spacerWidth)];
        }
    }];

    if (shouldAddLeftAndRightMargin) {
        [viewsAndSpacers insertObject:@(spacerWidth) atIndex:0];
        [viewsAndSpacers addObject:@(spacerWidth)];
    }

    UIView *firstSubview = subviews.firstObject;
    [firstSubview pl_alignToAttribute:NSLayoutAttributeLeft ofView:self withOffset:0];

    [self pl_alignViewsHorizontally:viewsAndSpacers];
}

#pragma mark - Edges

- (void)pl_expandToSuperViewEdges {
    self.pl_frame = self.superview.bounds;
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
    CGRect frame = self.pl_frame;
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
    self.pl_frame = frame;
}

#pragma mark - Center

#pragma mark - Relative

- (void)pl_alignToCenterOfView:(UIView *)view {
    [self pl_alignToCenterXOfView:view];
    [self pl_alignToCenterYOfView:view];
}

- (void)pl_alignToCenterXOfView:(UIView *)view {
    [self pl_alignToAttribute:NSLayoutAttributeCenterX ofView:view withOffset:0];
}

- (void)pl_alignToCenterYOfView:(UIView *)view {
    [self pl_alignToAttribute:NSLayoutAttributeCenterY ofView:view withOffset:0];
}

#pragma mark - Absolute

- (void)pl_centerInSuperView {
    [self pl_centerXInSuperView];
    [self pl_centerYInSuperView];
}

- (void)pl_centerXInSuperView {
    [self pl_alignToSuperViewAttribute:NSLayoutAttributeCenterX withOffset:0];
}

- (void)pl_centerYInSuperView {
    [self pl_alignToSuperViewAttribute:NSLayoutAttributeCenterY withOffset:0];
}

#pragma mark - Above

- (void)pl_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeCenterX ofView:view withOffset:0];
}

- (void)pl_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeLeft ofView:view withOffset:0];
}

- (void)pl_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeAbove:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeRight ofView:view withOffset:0];
}

#pragma mark - Under

- (void)pl_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeCenterX ofView:view withOffset:0];
}

- (void)pl_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeLeft ofView:view withOffset:0];
}

- (void)pl_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_placeUnder:view withMargin:margin];
    [self pl_alignToAttribute:NSLayoutAttributeRight ofView:view withOffset:0];
}

#pragma mark - Core

- (void)pl_placeUnder:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_alignAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:view multiplier:1 offset:margin];
}

- (void)pl_placeAbove:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_alignAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeTop ofView:view multiplier:1 offset:-margin];
}

- (void)pl_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_alignAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeLeft ofView:view multiplier:1 offset:-margin];
}

- (void)pl_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin {
    [self pl_alignAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight ofView:view multiplier:1 offset:margin];
}

- (void)pl_alignToSuperViewAttribute:(NSLayoutAttribute)edgeAttribute withOffset:(CGFloat)offset {
    [self pl_alignToAttribute:edgeAttribute ofView:self.superview withOffset:offset];
}

- (void)pl_alignToAttribute:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withOffset:(CGFloat)offset {
    [self pl_alignAttribute:edgeAttribute toAttribute:edgeAttribute ofView:view multiplier:1 offset:offset];
}

#pragma mark - Total alignment

- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view {
    [self pl_alignAttribute:attribute toAttribute:outerAttribute ofView:view multiplier:1.f offset:0];
}

- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view offset:(CGFloat)offset {
    [self pl_alignAttribute:attribute toAttribute:outerAttribute ofView:view multiplier:1.f offset:offset];
}

- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier {
    [self pl_alignAttribute:attribute toAttribute:outerAttribute ofView:view multiplier:multiplier offset:0];
}

- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier offset:(CGFloat)offset {
    if (attribute == NSLayoutAttributeNotAnAttribute || outerAttribute == NSLayoutAttributeNotAnAttribute) {
        return;
    }

    __block NSDictionary *matchedGetterAttributes = nil;
    __block NSDictionary *matchedSetterAttributes = nil;

    [getterAttributes enumerateObjectsUsingBlock:^(NSDictionary *attributes, NSUInteger idx, BOOL *stop) {
        NSSet *attributeKeys = [NSSet setWithArray:attributes.allKeys];
        BOOL match = [attributeKeys containsObject:@(attribute)] && [attributeKeys containsObject:@(outerAttribute)];
        if (match) {
            matchedGetterAttributes = attributes;
            matchedSetterAttributes = setterAttributes[idx];
            *stop = YES;
        }
    }];

    if (!matchedGetterAttributes) {
        @throw [NSException exceptionWithName:PLXFrameLayoutNotSupportedAttributeExceptionName
                                       reason:[NSString stringWithFormat:@"Attribute '%@' does not match with the attribute '%@'",
                                                                         PLX_NSStringFromLayoutAttributes(attribute),
                                                                         PLX_NSStringFromLayoutAttributes(outerAttribute)]
                                     userInfo:nil];
    }

    if ([view isEqual:self.superview]) {
        view.pl_shouldUseBoundsInsteadOfFrame = YES;
    }

    SEL outerAttributeSelector = NSSelectorFromString(matchedGetterAttributes[@(outerAttribute)]);
    CGFloat outerAttributeValue = CGFloatMsgSend(view, outerAttributeSelector);
    view.pl_shouldUseBoundsInsteadOfFrame = NO;

    CGFloat value = outerAttributeValue * multiplier + offset;

    SEL innerAttributeSelector = NSSelectorFromString(matchedSetterAttributes[@(attribute)]);
    setCGFloatMsgSend(self, innerAttributeSelector, value);
}

#pragma mark - Helpers

- (void)pl_sizeToFitSubviews {
    for (UIView *subview in self.subviews) {
        [subview sizeToFit];
    }
}

- (BOOL)pl_shouldUseBoundsInsteadOfFrame {
    return [objc_getAssociatedObject(self, @selector(pl_shouldUseBoundsInsteadOfFrame)) boolValue];
}

- (void)setPl_shouldUseBoundsInsteadOfFrame:(BOOL)shouldUseBoundsInsteadOfFrame {
    objc_setAssociatedObject(self, @selector(pl_shouldUseBoundsInsteadOfFrame), @(shouldUseBoundsInsteadOfFrame), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

NSString *PLX_NSStringFromLayoutAttributes(NSLayoutAttribute attribute) {
    const char *c_str = 0;
#define PROCESS_VAL(p) case(p): c_str = #p; break;
    switch (attribute) {
        PROCESS_VAL(NSLayoutAttributeLeft)
        PROCESS_VAL(NSLayoutAttributeRight)
        PROCESS_VAL(NSLayoutAttributeTop)
        PROCESS_VAL(NSLayoutAttributeBottom)
        PROCESS_VAL(NSLayoutAttributeLeading)
        PROCESS_VAL(NSLayoutAttributeTrailing)
        PROCESS_VAL(NSLayoutAttributeWidth)
        PROCESS_VAL(NSLayoutAttributeHeight)
        PROCESS_VAL(NSLayoutAttributeCenterX)
        PROCESS_VAL(NSLayoutAttributeCenterY)
        PROCESS_VAL(NSLayoutAttributeBaseline)
        PROCESS_VAL(NSLayoutAttributeFirstBaseline)
        PROCESS_VAL(NSLayoutAttributeLeftMargin)
        PROCESS_VAL(NSLayoutAttributeRightMargin)
        PROCESS_VAL(NSLayoutAttributeTopMargin)
        PROCESS_VAL(NSLayoutAttributeBottomMargin)
        PROCESS_VAL(NSLayoutAttributeLeadingMargin)
        PROCESS_VAL(NSLayoutAttributeTrailingMargin)
        PROCESS_VAL(NSLayoutAttributeCenterXWithinMargins)
        PROCESS_VAL(NSLayoutAttributeCenterYWithinMargins)
        PROCESS_VAL(NSLayoutAttributeNotAnAttribute)
    }
#undef PROCESS_VAL
    return [NSString stringWithCString:c_str encoding:NSASCIIStringEncoding];
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
                                           reason:[NSString stringWithFormat:PLXFrameLayoutNotSupportedAttributeExceptionReasonFormat,
                                                                             PLX_NSStringFromLayoutAttributes(edgeAttribute)]
                                         userInfo:nil];
    }
    self.frame = frame;
}

@end
