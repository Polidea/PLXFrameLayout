# FrameLayout

###Short Desciption
**FrameLayout** is a small tool for positioning, sizing and arranging views without using CGRects. **FrameLayout** also provides sets of convinient read-write properties that extract/set discrete values from view's frame, like: width, height, minX/Y, maxX/Y.

###How it works
**FrameLayout** is defined as a category on `UIView` class. It contains set of methods to configure view's sizes and positions in relation to its superviews or other views. Under the hood all **FrameLayout** methods calculates and sets `view.frame` property.

###Instalation

#####Pods instalation

1. Add the pod **FrameLayout** to your Podfile:

	```
	pod 'FrameLayout'
	```
2. Run ```pod install``` from Terminal, then open your app's .xcworkspace file to launch yout IDE.

3. Import the header file:
 
	```
	#import "UIView+PLFrameLayout.h"
	```

#####Manual instalation
1. Drag and drop `UIView+PLFrameLayout.h` and `UIView+PLFrameLayout.m`  to your project;
2. In *File Inspector*, make sure that `UIView+PLFrameLayout.m` belongs to your app target;
3. Add `#import UIView+PLFrameLayout.h` to your file.

###Usage
To make sure that superview's frame is already set, you should place all methods from **FrameLayout** library in your view's ```-layoutSubviews``` method.


###Examples
Aligning to top-left corner with 50 points margin:

```
- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		UIView *view = [UIView new]; // Calls `initWithFrame:CGRectZero` by default.
		[self addSubviews:view];
		self.myView = view;
	}
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.myView.pl_size = CGSizeMake(70.0, 70.0);
	[self.myView pl_alignToSuperView:NSLayoutAttributeTop withMargin:50.0];
	[self.myView pl_alignToSuperView:NSLayoutAttributeLeft withMargin:50.0];
}
```

For more, see example app.

###Contribution
**Frame Layout** project is on early stage. Feel free to contribute by pull requests.

###License
**FrameLayout** is released under a MIT License. See LICENSE file for details.