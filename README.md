# PLXFrameLayout

###Desciption
**PLXFrameLayout** is a small frame for positioning, sizing and arranging views without using CGRects. **PLXFrameLayout** also provides set of convinient read-write properties that extract/set discrete values from view's frame, like: width, height, minX/Y, maxX/Y.

It's _not_ Autolayout support. You can use it with Autolayout if needed.

###How it works
**PLXFrameLayout** is defined as a category on `UIView` class. It contains set of methods to configure view's sizes and positions in relation to its superviews or other views. Under the hood all **PLXFrameLayout** methods calculates and sets `view.frame` property.

###How to use

Let's consider following typical layout on frames.

```objective-c
- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.titleLabel sizeToFit];
	CGRect titleLabelFrame = self.titleLabel.frame;
	titleLabelFrame.origin.x = CGRectGetMidX(self.bounds) - (CGRectGetWidth(titleLabelFrame) * 0.5f);
	titleLabelFrame.origin.y = CGRectGetMidY(self.bounds) - (CGRectGetHeight(titleLabelFrame) * 0.5f);
	self.titleLabel.frame = titleLabelFrame;
	
	[self.captionLabel sizeToFit];
	CGRect captionLabelFrame = self.captionLabel.frame;
	captionLabelFrame.origin.y = CGRectGetMaxY(self.titleLabel.frame) + 10.f;
	captionLabelFrame.origin.x = CGRectGetMinX(self.titleLabel.frame);
	self.captionLabel.frame = captionLabelFrame;
	
	CGRect otherViewFrame = self.otherView.frame;
	otherViewFrame.origin.x = CGRectGetMaxX(self.titleLabel.frame) + 10.f;
	otherViewFrame.origin.y = CGRectGetMidY(self.titleLabel.frame) - (CGRectGetHeight(otherViewFrame) * 0.5f);
	otherViewFrame.size.width = CGRectGetWidth(self.bounds) - CGRectGetMinX(otherViewFrame) - 10.f;
	self.otherView.frame = otherViewFrame;
}
```

Now, let's look at implementation using `PLXFrameLayout`.

```objective-c
- (void)layoutSubviews {
	[super layoutSubviews];
	[self plx_sizeToFitSubviews];
	
	[self.titleLabel plx_centerInSuperView];
	[self.captionLabel plx_placeUnderAligningToLeft:self.titleLabel withMargin:10.f];
	[self.otherView plx_placeOnRightOf:self.titleLabel withMargin:10.f];
	[self.otherView plx_expandToSuperViewEdge:NSLayoutAttributeRight withInset:10.f];
	[self.otherView plx_alignToAttribute:NSLayoutAttributeCenterY ofView:self.titleLabel offset:0];
}
```

It's one way of how it could be done with `PLXFrameLayout`. It looks much better and more legible than usual code with lots of `CGRect` functions and structs copies.

In first line we center the view in superview with one method call. Then we place `captionLabel` under `titleLabel` and align its `x` to the same property value of `titleView` - all with one method.
`otherView` is placed on right of `titleLabel`, then its width is expanded so `maxX` is equal to super view `maxX` minus inset (`10.f`), and finally it's centered relatively to `titleLabel` center `y`.

###Installation

#####Pods installation

1. Add the pod **PLXFrameLayout** to your Podfile:

	```
	pod 'PLXFrameLayout'
	```
	
2. Run `pod install` from Terminal, then open your app's .xcworkspace file to launch your IDE.

3. Import the header file:
 
	```objective-c
	#import "UIView+PLXFrameLayout.h"
	```

#####Manual instalation
1. Drag and drop `UIView+PLXFrameLayout.h` and `UIView+PLXFrameLayout.m`  to your project;
2. In *File Inspector*, make sure that `UIView+PLXFrameLayout.m` belongs to your app target;
3. Add `#import UIView+PLXFrameLayout.h` to your file.

###Detailed usage

####Assignable properties

There are a few most common properties that you may want to change to achieve desired layout of the view.

```objective-c
@property(nonatomic, assign, setter=pl_setMinY:) CGFloat plx_minY;
@property(nonatomic, assign, setter=pl_setMidY:) CGFloat plx_midY;
@property(nonatomic, assign, setter=pl_setMaxY:) CGFloat plx_maxY;
@property(nonatomic, assign, setter=pl_setMinX:) CGFloat plx_minX;
@property(nonatomic, assign, setter=pl_setMidX:) CGFloat plx_midX;
@property(nonatomic, assign, setter=pl_setMaxX:) CGFloat plx_maxX;
@property(nonatomic, assign, setter=pl_setWidth:) CGFloat plx_width;
@property(nonatomic, assign, setter=pl_setHeight:) CGFloat plx_height;
@property(nonatomic, assign, setter=pl_setSize:) CGSize plx_size;
@property(nonatomic, assign, setter=pl_setFrame:) CGRect plx_frame;
```

Each property is assignable. That means that it's no longer necessary to make a copy of `CGRect` change it and assign back. E.g. modifiyng `plx_midX` changes the `x` value of view's frame considering its width, so it can be treated as center x of that view.

####Centering

There are a few methods that allow easily center the view relatively to its superview or sibling.

```objective-c
- (void)plx_centerInSuperView;
- (void)plx_centerXInSuperView;
- (void)plx_centerYInSuperView;

- (void)plx_alignToCenterOfView:(UIView *)view;
- (void)plx_alignToCenterXOfView:(UIView *)view;
- (void)plx_alignToCenterYOfView:(UIView *)view;
```

####Alignment

There are lots of methods that make views' alignment easy.

#####Core

The most fundamental method allows to align any attributes of two given views. Howerver not all attributes' combinations make sense or are supported.

```objective-c
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view offset:(CGFloat)offset;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier;
- (void)plx_alignAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)outerAttribute ofView:(UIView *)view multiplier:(CGFloat)multiplier offset:(CGFloat)offset;
``` 

Last method is the basic one, all others are just syntactic sugar. It look similarly to its Autolayout equivalent and behaves similarly as well.

If you want to align the same attributes of both views you may use additional method:

```objective-c
- (void)plx_alignToAttribute:(NSLayoutAttribute)edgeAttribute ofView:(UIView *)view withOffset:(CGFloat)offset;
```

Finally, there's one method that allows to align given attribute of the view to the same attribute of its superview:

```objective-c
- (void)plx_alignToSuperViewAttribute:(NSLayoutAttribute)edgeAttribute withOffset:(CGFloat)offset;
```

#####Handy helpers

Following methods are easy to use and understand. They help to position view relatively to the given view: under/above/on the left/right. Two of them have additional variations with extra alignment in X axis.

Note: `margin` has always positive value (in opposite to `offset` parameter above). E.g. using `plx_placeOnLeftOf:withMargin:` positive `margin` value will move view more to the left (_not_ to the right, in the X axis direction).

```objective-c 
- (void)plx_placeUnder:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAbove:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeOnLeftOf:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeOnRightOf:(UIView *)view withMargin:(CGFloat)margin;

- (void)plx_placeAboveAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAboveAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeAboveAligningToRight:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeUnderAligningCenterX:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeUnderAligningToLeft:(UIView *)view withMargin:(CGFloat)margin;
- (void)plx_placeUnderAligningToRight:(UIView *)view withMargin:(CGFloat)margin;
```

#####Batch alignment

There are two core methods `plx_alignViewsVertically`: and `plx_alignViewsHorizontally:` with their variations to allow batch views alignment. They accept an array of views _and_ numbers (as spacec between those views).

Note: Each method retuns total calculated height of all aligned views with spaces.

```objective-c
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsVerticallyCentering:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)plx_alignViewsVertically:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;

- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsHorizontallyCentering:(NSArray *)viewsAndSpacings;
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings centeringWithMargin:(CGFloat)spaceFromCenter;
- (CGFloat)plx_alignViewsHorizontally:(NSArray *)viewsAndSpacings additionallyAligningTo:(NSLayoutAttribute)attribute withMargin:(CGFloat)marginFromAttribute;
```

Here is an example.

```objective-c
[self plx_alignViewsVertically:@[
	self.titleLabel,
	@20,
	self.captionLabel,
]];
```

This code means that `titleLabel` will be aligned to the superview's top, then under it after `20` points `captionLabel` will be places. In this example `x` property value will not be modified.

####Expand

There are methods that help to expand views as well (not only align their edges).

```objective-c
- (void)plx_expandToSuperViewEdges;
- (void)plx_expandToSuperViewEdgesWithInsets:(UIEdgeInsets)insets;
 
- (void)plx_expandToSuperViewHorizontalEdgesWithInsets:(UIEdgeInsets)insets;
- (void)plx_expandToSuperViewVerticalEdgesWithInsets:(UIEdgeInsets)insets;

- (void)plx_expandToSuperViewEdge:(NSLayoutAttribute)edge withInset:(CGFloat)inset;
```

First two methods resize the view to the superview bounds. It similar to the: `self.titleLabel.frame = self.bounds;`, however you may pass insets if necessary.

Next two methods allow to expand view the only in desired axis: horizontal (X) or vertical (Y). That means e.g. if `self.titleLabel` should fill all the width of superview (from 0 to superview's bounds maxX) but not changing `y` and `height` properties - `plx_expandToSuperViewVerticalEdgesWithInsets:` should be used.

Last method allows to expand only one edge to the same edge of superview identified by `NSLayoutAttributeTop/Bottom/Left/Right`.

####Fill

Sometimes there are views that don't have intrinsic content size (e.g. scroll view) and their height (or width) has to be dynamically calculated and set. In this cases two following method may help.

```objective-c
- (void)plx_fillSuperViewVertically:(NSArray *)viewsAndSpacings expandableViews:(NSArray *)expandableViews;
- (void)plx_fillSuperViewHorizontally:(NSArray *)viewsAndSpacing expandableViews:(NSArray *)expandableViews;
```

They work similarly to the `plx_alignViewsVertically/Horizontally:` methods, but take one more paramter.
This is an array of views (that should be listed as well in first array parameter) that are allowed be expanded (not only aligned).

Here is an example.

```objective-c
[self plx_fillSuperViewVertically:@[
	self.titleLabel,
	self.tableView,
	self.footerLabel,
] expandableViews:@[self.tableView]];
```

It means that views will be aligned in vertical axis but table view will be additional expanded to fill all available superview space (height).

####Distribute

Sometimes there's a need to equally distribute views in superview (with equal margins between them).
Following methods are able to do that.

```objective-c
- (void)plx_distributeSubviewsVerticallyInSuperView:(NSArray *)subviews withTopAndBottomMargin:(BOOL)shouldAddTopAndBottomMargins;
- (void)plx_distributeSubviewsHorizontallyInSuperView:(NSArray *)subviews withLeftAndRightMargin:(BOOL)shouldAddLeftAndRightMargin;
```

Note: The second parameter of each method determines whether the margin between super view edges and first and last views should be consider in computation.

###Contribution

Feel free to contribute by pull requests or create issues.

###License
**PLXFrameLayout** is released under a MIT License. See LICENSE file for details.