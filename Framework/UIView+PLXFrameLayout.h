//
// Created by Maciej Oczko on 16/04/15.
// Copyright (c) 2015 polidea.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (PLXFrameLayout)

/**
 *  Represents minY of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMinY:) CGFloat pl_minY;

/**
 *  Represents midY of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMidY:) CGFloat pl_midY;

/**
 *  Represents maxY of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMaxY:) CGFloat pl_maxY;

/**
 *  Represents mixX of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMinX:) CGFloat pl_minX;

/**
 *  Represents midX of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMidX:) CGFloat pl_midX;

/**
 *  Represents maxX of the view's frame. Assignable.
 */
@property(nonatomic, assign, setter=pl_setMaxX:) CGFloat pl_maxX;

/**
 *  Represents width of the view. Assignable.
 */
@property(nonatomic, assign, setter=pl_setWidth:) CGFloat pl_width;

/**
 *  Represents height of the view. Assignable.
 */
@property(nonatomic, assign, setter=pl_setHeight:) CGFloat pl_height;

/**
 *  Represents size of the view. Assignable.
 */
@property(nonatomic, assign, setter=pl_setSize:) CGSize pl_size;

/**
 *  Represents frame of the view.
 */
@property(nonatomic, assign, setter=pl_setFrame:) CGRect pl_frame;

#pragma mark - Centering

/**
 *  Calls sizeToFit on each subview.
 */
- (void)plx_sizeToFitSubviews;

/**
 *  Centers view in superview.
 */
- (void)plx_centerInSuperView;

/**
 *  Centers view in superview horizontally.
 */
- (void)plx_centerXInSuperView;

/**
 *  Centers view in super vertically.
 */
- (void)plx_centerYInSuperView;

#pragma mark - Batch views alignment

/**
 *  Aligns given views one by one vertically.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *
 *  @return Total height of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's top with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings;

/**
 *  Aligns given views one by one vertically centering them in superview.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *
 *  @return Total height of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's top with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings;

/**
 *  Aligns given views one by one vertically centering them in superview with given margin.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param spaceFromCenter  An offset from center Y axis.
 *
 *  @return Total height of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's top with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;

/**
 *  Aligns given views one by one vertically that allows to additionally align them in Y axis with to the given attribute.
 *
 *  @param viewsAndSpacings    Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param attribute           An attribute of superview that views edges of the same attribute will be aligned to.
 *  @param marginFromAttribute An offset that will be added to the alignment result.
 *
 *
 *  @return Total height of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's top with non-zero margin if the first item of array is spacing.
 *
 *  To skip additional alignment NSLayoutAttributeNotAnAttribute has to be passed as a second paramenter.
 */
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

/**
 *  Aligns given views one by one horizontally.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *
 *  @return Total width of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's left with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings;

/**
 *  Aligns given views one by one horizontally centering them in superview.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *
 *  @return Total width of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's left with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsHorizontallyCentering:(NSArray *)viewsAndSpacings;

/**
 *  Aligns given views one by one horizontally centering them in superview with an offset from X axis.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param spaceFromCenter  An offset from center X axis.
 *
 *  @return Total width of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's left with non-zero margin if the first item of array is spacing.
 */
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;


/**
 *  Aligns given views one by one horizontally that allows to additionally align them in X axis with to the given attribute.
 *
 *  @param viewsAndSpacings    Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param attribute           An attribute of superview that views edges of the same attribute will be aligned to.
 *  @param marginFromAttribute An offset that will be added to the alignment result.
 *
 *
 *  @return Total width of aligned views.
 *
 *  @discussion viewsAndSpacings may contain spacings which must be instances of NSNumber (later used as CGFloats).
 *  Very first given view will be aligned to the superview's left with non-zero margin if the first item of array is spacing.
 *
 *  To skip additional alignment NSLayoutAttributeNotAnAttribute has to be passed as a second paramenter.
 */
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

#pragma mark - Relative view alignment

/**
 *  Aligns center of the receiver to the center of the given view.
 *
 *  @param view View to be aligned to.
 */
- (void)plx_alignToCenterOfView:(UIView *)view;

/**
 *  Aligns the receiver to the center of the given view in the X axis.
 *
 *  @param view View to be aligned to.
 */
- (void)plx_alignToCenterXOfView:(UIView *)view;

/**
 *  Aligns the receiver to the center of the given view in the Y axis.
 *
 *  @param view View to be aligned to.
 */
- (void)plx_alignToCenterYOfView:(UIView *)view;

/**
 *  Places the receiver above the given view with margin, centering it in the X axis relatively to given view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver above to given view, aligning it's left edge to the left edge of the view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver above to given view, aligning it's right edge to the right edge of the view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver under the given view with margin, centering it in the X axis relatively to given view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver under to given view, aligning it's left edge to the left edge of the view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver under to given view, aligning it's right edge to the right edge of the view.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver under the given view with margin.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeUnder:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver above the given view with margin.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeAbove:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver on the left the given view with margin.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin;

/**
 *  Places the receiver above the given view with margin.
 *
 *  @param view   View to be aligned to.
 *  @param margin Margin between the receiver and the given view.
 */
- (void)plx_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin;

#pragma mark - Core alignment methods

/**
 *  Aligns given attribute of the receiver to the same attribute of it's superview.
 *
 *  @param edgeAttribute Attribute to be align to.
 *  @param offset        Offset from the base computed attribute value.
 */
- (void)plx_alignToSuperViewAttribute:(NSLayoutAttribute)edgeAttribute withOffset:(CGFloat)offset;

/**
 *  Aligns given attribute of the receiver to the same attribute of other view with offset.
 *
 *  @param edgeAttribute Attribute to be align to.
 *  @param view          View to be aligned relatively to.
 *  @param offset        Offset is offset.
 */
- (void)plx_alignToAttribute:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withOffset:(CGFloat)offset;

/**
 *  Aligns given attribute of the receiver to any given attribute of given view.
 *
 *  @param attribute      Receiver's attribute.
 *  @param outerAttribute Attribute of view to be aligned to.
 *  @param view           View to be aligned to.
 */
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view;

/**
 *  Aligns given attribute of the receiver to any given attribute of given view with offset.
 *
 *  @param attribute      Receiver's attribute.
 *  @param outerAttribute Attribute of view to be aligned to.
 *  @param view           View to be aligned to.
 *  @param offset         Offset between base attributes values.
 */
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view offset:(CGFloat)offset;

/**
 *  Aligns given attribute of the receiver to any given attribute of given view with multiplier.
 *
 *  @param attribute      Receiver's attribute.
 *  @param outerAttribute Attribute of view to be aligned to.
 *  @param view           View to be aligned to.
 *  @param multiplier     Number by which value of outer attribute will be multiplied during computation. Usually equals 1.
 */
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier;

/**
 *  Aligns given attribute of the receiver to any given attribute of given view with multiplier and offset.
 *
 *  @param attribute      Receiver's attribute.
 *  @param outerAttribute Attribute of view to be aligned to.
 *  @param view           View to be aligned to.
 *  @param multiplier     Number by which value of outer attribute will be multiplied during computation. Usually equals 1.
 *  @param offset         Offset between base attributes values.
 */
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier offset:(CGFloat)offset;

#pragma mark - View expanding

/**
 *  Expands receiver frame to its superview bounds.
 */
- (void)plx_expandToSuperViewEdges;

/**
 *  Expands receiver frame to its superview bounds with insets.
 *
 *  @param insets Insets to be applied to layout.
 */
- (void)plx_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets;

/**
 *  Expands receiver's horizontal edges (top and bottom) to the superview edges with insets.
 *
 *  @param insets Insets to be applied to layout.
 *  
 *  @discussion Only top and bottom insets of the parameters's struct are considered in computation.
 */
- (void)plx_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets;

/**
 *  Expands receiver's vertical edges (left and right) to the superview edges with insets.
 *
 *  @param insets Insets to be applied to layout.
 *
 *  @discussion Only left and right insets of the parameters's struct are considered in computation.
 */
- (void)plx_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets;

/**
 *  Expands receiver's given edge (attribute) to the same edge (attribute) of it's superview with inset.
 *
 *  @param edge  Attribute that identifies edge that will be expanded.
 *  @param inset Inset to be applied to layout.
 */
- (void)plx_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset;

/**
 *  Aligns given views one by one vertically in superview expanding particular selected views.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param expandableViews  Array of views that height will be dynamically computed to fill all the space.
 *
 *  @discussion This method works similarly to plx_alignViewsVertically: but accepts views without specified content size to be dynamically expanded (e.g. scroll views).
 */
- (void)plx_fillSuperViewVertically:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews;

/**
 *  Aligns given views one by one horizontally in superview expanding particular selected views.
 *
 *  @param viewsAndSpacings Array of views and spacings. Spacing must be an instance of NSNumber.
 *  @param expandableViews  Array of views that height will be dynamically computed to fill all the space.
 *
 *  @discussion This method works similarly to plx_alignViewsHorizontally: but accepts views without specified content size to be dynamically expanded (e.g. scroll views).
 */
- (void)plx_fillSuperViewHorizontally:(NSArray *)viewsAndSpacing expandableViews:(NSArray *)expandableViews;

/**
 *  Distributes given views equally in superview in Y axis.
 *
 *  @param subviews                     Array of views to be aligned.
 *  @param shouldAddTopAndBottomMargins Determines whether to consider margins during computation.
 *
 *  @discussion Last parameter specifies if during computation views should be aligned to the superview's edges
 *  or between top (and bottom) view and appropriate edge of the superview should be space equal to the space between views.
 */
- (void)plx_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins;

/**
 *  Distributes given views equally in superview in X axis.
 *
 *  @param subviews                     Array of views to be aligned.
 *  @param shouldAddLeftAndRightMargin Determines whether to consider margins during computation.
 *
 *  @discussion Last parameter specifies if during computation views should be aligned to the superview's edges
 *  or between left (and right) view and appropriate edge of the superview should be space equal to the space between views.
 */
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
