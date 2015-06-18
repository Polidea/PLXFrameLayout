//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (PLFrameLayout)
@property(nonatomic, assign) CGFloat pl_minY;
@property(nonatomic, assign) CGFloat pl_maxY;
@property(nonatomic, assign) CGSize pl_size;
@property(nonatomic, assign) CGFloat pl_width;
@property(nonatomic, assign) CGFloat pl_height;

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings;

- (CGFloat)pl_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings;

- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)pl_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)pl_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (void)pl_expandToSuperViewEdges;
- (void)pl_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets;

- (void)pl_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)pl_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)pl_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset;

- (void)pl_centerXInSuperView;
- (void)pl_centerYInSuperView;

- (void)pl_alignToCenterXOfView:(UIView *)view;
- (void)pl_alignToCenterYOfView:(UIView *)view;

- (void)pl_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)pl_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)pl_placeUnder:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeAbove:(UIView *)view withMargin:(CGFloat)margin;

- (void)pl_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin;
- (void)pl_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin;

- (void)pl_alignToSuperView:(NSLayoutAttribute)edgeAttribute withMargin:(CGFloat)margin;
- (void)pl_alignTo:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withMargin:(CGFloat)margin;

- (void)pl_sizeToFitSubviews;

-(void)pl_fillSuperViewVerticallyWithViews:(NSArray *)viewsAndSpacing expandableViews:(NSSet *)expandableViews;
-(void)pl_fillSuperViewHorizontallyWithViews:(NSArray *)viewsAndSpacing expandableViews:(NSSet *)expandableViews;

-(void)pl_arrangeSubViewsVerticallyInSuperView:(NSArray *)subviews addTopAndBottomSpaces:(BOOL)topAndBottomSpaces;
-(void)pl_arrangeSubViewsHorizontallyInSuperView:(NSArray *)subviews addLeadingAndTrailingSpaces:(BOOL)leadingAndTralingSpaces;

@end
