# PLXFrameLayout

###Desciption
**PLXFrameLayout** is a small frame for positioning, sizing and arranging views without using CGRects. **PLXFrameLayout** also provides set of convinient read-write properties that extract/set discrete values from view's frame, like: width, height, minX/Y, maxX/Y.

It's _not_ Autolayout. You can use it with Autolayout if needed.

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




For more, see example app.

###Contribution
Feel free to contribute by pull requests or create issues.

###License
**PLXFrameLayout** is released under a MIT License. See LICENSE file for details.