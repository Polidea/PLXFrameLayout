//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (PLXFrameLayout)
@property(nonatomic, assign, setter=pl_setMinY:) CGFloat pl_minY;
@property(nonatomic, assign, setter=pl_setMidY:) CGFloat pl_midY;
@property(nonatomic, assign, setter=pl_setMaxY:) CGFloat pl_maxY;

@property(nonatomic, assign, setter=pl_setMinX:) CGFloat pl_minX;
@property(nonatomic, assign, setter=pl_setMidX:) CGFloat pl_midX;
@property(nonatomic, assign, setter=pl_setMaxX:) CGFloat pl_maxX;

@property(nonatomic, assign, setter=pl_setWidth:) CGFloat pl_width;
@property(nonatomic, assign, setter=pl_setHeight:) CGFloat pl_height;
@property(nonatomic, assign, setter=pl_setSize:) CGSize pl_size;
@property(nonatomic, assign, setter=pl_setFrame:) CGRect pl_frame;

- (void)plx_sizeToFitSubviews;

- (void)plx_centerInSuperView;
- (void)plx_centerXInSuperView;
- (void)plx_centerYInSuperView;

- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings;

- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsHorizontallyCentering:(NSArray *)viewsAndSpacings;

- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (void)plx_alignToCenterOfView:(UIView *)view;
- (void)plx_alignToCenterXOfView:(UIView *)view;
- (void)plx_alignToCenterYOfView:(UIView *)view;

- (void)plx_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)plx_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)plx_placeUnder:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAbove:(UIView *)view withMargin:(CGFloat)margin;

- (void)plx_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin;

- (void)plx_alignToSuperViewAttribute:(NSLayoutAttribute)edgeAttribute withOffset:(CGFloat)offset;
- (void)plx_alignToAttribute:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withOffset:(CGFloat)offset;

- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view offset:(CGFloat)offset;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier offset:(CGFloat)offset;

- (void)plx_expandToSuperViewEdges;
- (void)plx_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets;

- (void)plx_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)plx_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)plx_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset;

- (void)plx_fillSuperViewVertically:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews;
- (void)plx_fillSuperViewHorizontally:(NSArray *)viewsAndSpacing expandableViews:(NSArray *)expandableViews;

- (void)plx_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins;
- (void)plx_distributeSubviewsHorizontallyInSuperView:(NSArray *)subviews withLeftAndRightMargin:(BOOL)shouldAddLeftAndRightMargin;

#pragma mark - Deprecated API

- (void)pl_fillSuperViewVerticallyWithViews:(NSArray *)views expandableViews:(NSSet *)expandableViews __attribute__((deprecated("Use -plx_fillSuperViewVertically:expandableViews: instead.")));
- (void)pl_fillSuperViewHorizontallyWithViews:(NSArray *)views expandableViews:(NSSet *)expandableViews __attribute__((deprecated("Use -plx_fillSuperViewHorizontally:expandableViews: instead.")));

- (void)pl_arrangeSubViewsVerticallyInSuperView:(NSArray *)subviews addTopAndBottomSpaces:(BOOL)topAndBottomSpaces __attribute__((deprecated("Use -plx_distributeSubviewsVerticallyInSuperView:withTopAndBottomMargin: instead.")));
- (void)pl_arrangeSubViewsHorizontallyInSuperView:(NSArray *)subviews addLeadingAndTrailingSpaces:(BOOL)leadingAndTrailingSpaces __attribute__((deprecated("Use -pl_distributeSubviewsHorizontallyInSuperView:withTopAndBottomMargin: instead.")));

- (void)pl_alignToSuperView:(NSLayoutAttribute)edgeAttribute withMargin:(CGFloat)margin __attribute__((deprecated("Use -plx_alignToSuperViewAttribute:withOffset: instead.")));
- (void)pl_alignTo:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withMargin:(CGFloat)margin __attribute__((deprecated("Use -plx_alignToAttribute:ofView:withOffset: instead.")));

#pragma mark - Deprecated prefix
#define PLXDeprecatedPrefix __attribute__((deprecated("Use method with 'plx_' prefix instead.")))

- (void)pl_sizeToFitSubviews PLXDeprecatedPrefix;

- (void)pl_centerInSuperView PLXDeprecatedPrefix;
- (void)pl_centerXInSuperView PLXDeprecatedPrefix;
- (void)pl_centerYInSuperView PLXDeprecatedPrefix;

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings PLXDeprecatedPrefix;
- (CGFloat)pl_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings PLXDeprecatedPrefix;

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter PLXDeprecatedPrefix;
- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute PLXDeprecatedPrefix;

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings PLXDeprecatedPrefix;
- (CGFloat)pl_alignViewsHorizontallyCentering:(NSArray *)viewsAndSpacings PLXDeprecatedPrefix;

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter PLXDeprecatedPrefix;
- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute PLXDeprecatedPrefix;

- (void)pl_alignToCenterOfView:(UIView *)view PLXDeprecatedPrefix;
- (void)pl_alignToCenterXOfView:(UIView *)view PLXDeprecatedPrefix;
- (void)pl_alignToCenterYOfView:(UIView *)view PLXDeprecatedPrefix;

- (void)pl_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;

- (void)pl_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;

- (void)pl_placeUnder:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeAbove:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;

- (void)pl_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;
- (void)pl_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin PLXDeprecatedPrefix;

- (void)pl_alignToSuperViewAttribute:(NSLayoutAttribute)edgeAttribute withOffset:(CGFloat)offset PLXDeprecatedPrefix;
- (void)pl_alignToAttribute:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withOffset:(CGFloat)offset PLXDeprecatedPrefix;

- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view PLXDeprecatedPrefix;
- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view offset:(CGFloat)offset PLXDeprecatedPrefix;
- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier PLXDeprecatedPrefix;
- (void)pl_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier offset:(CGFloat)offset PLXDeprecatedPrefix;

- (void)pl_expandToSuperViewEdges PLXDeprecatedPrefix;
- (void)pl_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets PLXDeprecatedPrefix;

- (void)pl_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets PLXDeprecatedPrefix;
- (void)pl_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets PLXDeprecatedPrefix;
- (void)pl_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset PLXDeprecatedPrefix;

- (void)pl_fillSuperViewVertically:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews PLXDeprecatedPrefix;
- (void)pl_fillSuperViewHorizontally:(NSArray *)viewsAndSpacing expandableViews:(NSArray *)expandableViews PLXDeprecatedPrefix;

- (void)pl_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins PLXDeprecatedPrefix;
- (void)pl_distributeSubviewsHorizontallyInSuperView:(NSArray *)subviews withLeftAndRightMargin:(BOOL)shouldAddLeftAndRightMargin PLXDeprecatedPrefix;

@end
