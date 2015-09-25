# PLXFrameLayout

###Short Desciption
**PLXFrameLayout** is a small tool for positioning, sizing and arranging views without using CGRects. **PLXFrameLayout** also provides sets of convinient read-write properties that extract/set discrete values from view's frame, like: width, height, minX/Y, maxX/Y.

###How it works
**PLXFrameLayout** is defined as a category on `UIView` class. It contains set of methods to configure view's sizes and positions in relation to its superviews or other views. Under the hood all **PLXFrameLayout** methods calculates and sets `view.frame` property.

###Instalation

#####Pods instalation

1. Add the pod **PLXFrameLayout** to your Podfile:

	```
	pod 'PLXFrameLayout'
	```
2. Run ```pod install``` from Terminal, then open your app's .xcworkspace file to launch yout IDE.

3. Import the header file:
 
	```
	#import "UIView+PLXFrameLayout.h"
	```

#####Manual instalation
1. Drag and drop `UIView+PLXFrameLayout.h` and `UIView+PLXFrameLayout.m`  to your project;
2. In *File Inspector*, make sure that `UIView+PLXFrameLayout.m` belongs to your app target;
3. Add `#import UIView+PLXFrameLayout.h` to your file.

###Usage
To make sure that superview's frame is already set, you should place all methods from **PLXFrameLayout** library in your view's ```-layoutSubviews``` method.


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
	self.myView.pl_size = CGSizeMake(70.0f, 70.0f);
	[self.myView pl_alignToSuperView:NSLayoutAttributeTop withMargin:50.0f];
	[self.myView pl_alignToSuperView:NSLayoutAttributeLeft withMargin:50.0f];
}
```

For more, see example app.

###Contribution
**PLXFrameLayout** project is on early stage. Feel free to contribute by pull requests.

###License
**PLXFrameLayout** is released under a MIT License. See LICENSE file for details.