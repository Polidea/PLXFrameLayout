#import "UIView+PLXFrameLayout.h"
#import <XCTest/XCTest.h>
#import "UIView+Utilities.h"

@interface UIView_FrameLayoutTest_Alignment : XCTestCase
@property(nonatomic, strong, readonly) NSArray *subviewsAndSpacings;
@property(nonatomic, strong, readonly) UIView *superView;
@end

@implementation UIView_FrameLayoutTest_Alignment

- (void)setUp {
    [super setUp];

    CGRect superViewFrame = CGRectMake(100, 200, 300, 300);
    UIView *superView = [[UIView alloc] initWithFrame:superViewFrame];
    _superView = superView;

    _subviewsAndSpacings = [UIView viewsAlignmentArrayWithCapacity:3
                                                    withBuildBlock:^UIView * {
                                             return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 11)];
                                         } defaultSpacing:19];

    for (id subViewOrSpacing in self.subviewsAndSpacings) {
        if ([subViewOrSpacing isKindOfClass:[UIView class]]) {
            [self.superView addSubview:subViewOrSpacing];
        }
    }
}

- (void)tearDown {
    [super tearDown];
    _subviewsAndSpacings = nil;
    _superView = nil;
}

#pragma MARK - General alignment

- (void)testAligning {
    UIView *firstView = self.superView.subviews[0];
    UIView *secondView = self.superView.subviews[1];

    [firstView plx_alignAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofView:secondView];
    XCTAssertEqualWithAccuracy(firstView.frame.origin.x, secondView.frame.origin.x, FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight ofView:secondView];
    XCTAssertEqualWithAccuracy(firstView.frame.origin.x, CGRectGetMaxX(secondView.frame), FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeCenterX toAttribute:NSLayoutAttributeLeft ofView:secondView];
    XCTAssertEqualWithAccuracy(CGRectGetMidX(firstView.frame), secondView.frame.origin.x, FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeLeft ofView:secondView];
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(firstView.frame), secondView.frame.origin.x, FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofView:secondView offset:10];
    XCTAssertEqualWithAccuracy(firstView.frame.origin.y, CGRectGetMaxY(secondView.frame) + 10, FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeCenterY ofView:secondView];
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(firstView.frame), CGRectGetMidY(secondView.frame), FLT_EPSILON, @"Wrong alignment");

    [firstView plx_alignAttribute:NSLayoutAttributeWidth toAttribute:NSLayoutAttributeHeight ofView:secondView multiplier:2];
    XCTAssertEqualWithAccuracy(CGRectGetWidth(firstView.frame), CGRectGetHeight(secondView.frame) * 2, FLT_EPSILON, @"Wrong alignment");
}

#pragma MARK - AlignViewsVertically

- (void)testAlignViewsVertically_verticalDistance {
    CGFloat totalHeight = [self.superView plx_alignViewsVertically:self.subviewsAndSpacings];

    CGRect firstViewFrame = [self.subviewsAndSpacings[1] frame];
    CGRect secondViewFrame = [self.subviewsAndSpacings[3] frame];
    CGRect thirdViewFrame = [self.subviewsAndSpacings[5] frame];

    XCTAssertEqualWithAccuracy(CGRectGetMinY(secondViewFrame) - CGRectGetMaxY(firstViewFrame), [self.subviewsAndSpacings[2] floatValue], FLT_EPSILON, @"Wrong vertical distance");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(thirdViewFrame) - CGRectGetMaxY(secondViewFrame), [self.subviewsAndSpacings[4] floatValue], FLT_EPSILON, @"Wrong vertical distance");

    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.subviewsAndSpacings], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalCentering {
    CGFloat margin = 0;

    CGFloat totalHeight = [self.superView plx_alignViewsVertically:self.subviewsAndSpacings additionallyAligningTo:NSLayoutAttributeCenterX
                                                        withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(firstView.center.x, CGRectGetMidX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");
    XCTAssertEqualWithAccuracy(secondView.center.x, CGRectGetMidX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");
    XCTAssertEqualWithAccuracy(thirdView.center.x, CGRectGetMidX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");

    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.subviewsAndSpacings], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignLeft {
    CGFloat margin = 19;

    CGFloat totalHeight = [self.superView plx_alignViewsVertically:self.subviewsAndSpacings
                                            additionallyAligningTo:NSLayoutAttributeLeft
                                                        withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(firstView.frame.origin.x, CGRectGetMinX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subview left alignment");
    XCTAssertEqualWithAccuracy(secondView.frame.origin.x, CGRectGetMinX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subview left alignment");
    XCTAssertEqualWithAccuracy(thirdView.frame.origin.x, CGRectGetMinX(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subview left alignment");

    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.subviewsAndSpacings], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignRight {
    CGFloat margin = 19;

    CGFloat totalHeight = [self.superView plx_alignViewsVertically:self.subviewsAndSpacings
                                            additionallyAligningTo:NSLayoutAttributeRight
                                                        withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(CGRectGetMaxX(firstView.frame), CGRectGetMaxX(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subview right alignment");
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(secondView.frame), CGRectGetMaxX(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subview right alignment");
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(thirdView.frame), CGRectGetMaxX(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subview right alignment");

    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.subviewsAndSpacings], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

#pragma MARK - AlignViewsHorizontally

- (void)testAlignViewsHorizontally_horizontalDistance {
    CGFloat totalWidth = [self.superView plx_alignViewsHorizontally:self.subviewsAndSpacings];

    CGRect firstViewFrame = [self.subviewsAndSpacings[1] frame];
    CGRect secondViewFrame = [self.subviewsAndSpacings[3] frame];
    CGRect thirdViewFrame = [self.subviewsAndSpacings[5] frame];

    XCTAssertEqualWithAccuracy(CGRectGetMinX(secondViewFrame) - CGRectGetMaxX(firstViewFrame), [self.subviewsAndSpacings[2] floatValue], FLT_EPSILON, @"Incorrect horizontal distance)");
    XCTAssertEqualWithAccuracy(CGRectGetMinX(thirdViewFrame) - CGRectGetMaxX(secondViewFrame), [self.subviewsAndSpacings[4] floatValue], FLT_EPSILON, @"Incorrect horizontal distance)");

    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.subviewsAndSpacings], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignCenter {
    CGFloat margin = 19;

    CGFloat totalWidth = [self.superView plx_alignViewsHorizontally:self.subviewsAndSpacings
                                             additionallyAligningTo:NSLayoutAttributeCenterY
                                                         withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(CGRectGetMidY(firstView.frame), CGRectGetMidY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews vertical center");
    XCTAssertEqualWithAccuracy(CGRectGetMidY(secondView.frame), CGRectGetMidY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews vertical center");
    XCTAssertEqualWithAccuracy(CGRectGetMidY(thirdView.frame), CGRectGetMidY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews vertical center");

    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.subviewsAndSpacings], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignTop {
    CGFloat margin = 19;

    CGFloat totalWidth = [self.superView plx_alignViewsHorizontally:self.subviewsAndSpacings
                                             additionallyAligningTo:NSLayoutAttributeTop
                                                         withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(CGRectGetMinY(firstView.frame), CGRectGetMinY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews top aling");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(secondView.frame), CGRectGetMinY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews top aling");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(thirdView.frame), CGRectGetMinY(self.superView.bounds) + margin, FLT_EPSILON, @"Incorrect subviews top aling");

    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.subviewsAndSpacings], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignBottom {
    CGFloat margin = 19;

    CGFloat totalWidth = [self.superView plx_alignViewsHorizontally:self.subviewsAndSpacings
                                             additionallyAligningTo:NSLayoutAttributeBottom
                                                         withMargin:margin];

    UIView *firstView = self.subviewsAndSpacings[1];
    UIView *secondView = self.subviewsAndSpacings[3];
    UIView *thirdView = self.subviewsAndSpacings[5];

    XCTAssertEqualWithAccuracy(CGRectGetMaxY(firstView.frame), CGRectGetMaxY(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subviews bottom aling");
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(secondView.frame), CGRectGetMaxY(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subviews bottom aling");
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(thirdView.frame), CGRectGetMaxY(self.superView.bounds) - margin, FLT_EPSILON, @"Incorrect subviews bottom aling");

    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.subviewsAndSpacings], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}


#pragma MARK - Helpers

- (CGFloat)totalHeightOfViewsAndSpacings:(NSArray *)viewsAndSpacing {
    CGFloat totalHeight = 0;
    for (id viewOrSpacing in viewsAndSpacing) {
        BOOL isUIViewKind = [viewOrSpacing isKindOfClass:[UIView class]];
        totalHeight += isUIViewKind ? CGRectGetHeight([viewOrSpacing frame]) : [viewOrSpacing floatValue];
    }
    return totalHeight;
}

- (CGFloat)totalWidthOfViewsAndSpacings:(NSArray *)viewsAndSpacing {
    CGFloat totalWidth = 0;
    for (id viewOrSpacing in viewsAndSpacing) {
        BOOL isUIViewKind = [viewOrSpacing isKindOfClass:[UIView class]];
        totalWidth += isUIViewKind ? CGRectGetWidth([viewOrSpacing frame]) : [viewOrSpacing floatValue];
    }
    return totalWidth;
}

@end
