//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (PLFrameLayout)
@property(nonatomic, assign) CGFloat minY;
@property(nonatomic, assign) CGFloat maxY;
@property(nonatomic, assign) CGSize size;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings;

- (CGFloat)alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings;

- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (void)pinToSuperViewEdges;
- (void)pinToSuperViewEdgesWithInsets:(UIEdgeInsets)insets;

- (void)pinToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)pinToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)pinToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset;

- (void)centerXInSuperView;
- (void)centerYInSuperView;

- (void)alignToCenterXOfView:(UIView *)view;
- (void)alignToCenterYOfView:(UIView *)view;

- (void)placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

- (void)placeUnder:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeAbove:(UIView *)view withMargin:(CGFloat)margin;

- (void)placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin;
- (void)placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin;

- (void)alignToSuperView:(NSLayoutAttribute)edgeAttribute withMargin:(CGFloat)margin;
- (void)alignTo:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withMargin:(CGFloat)margin;

- (void)sizeToFitSubviews;

-(void)fillSuperViewVerticalyWithViews:(NSArray *)viewsAndSpacing expandableViews:(NSSet *)expandableViews;
@end
