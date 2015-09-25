//
//  Created by Pawel Scibek on 09/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLXFrameLayout.h"

@interface UIView_FrameLayoutTest_pinning : XCTestCase
@property(nonatomic, strong, readonly) UIView *superView;
@property(nonatomic, strong, readonly) UIView *subView;
@property(nonatomic, assign, readonly) CGRect originalSubviewRect;
@end

@implementation UIView_FrameLayoutTest_pinning

- (void)setUp {
    [super setUp];

    _originalSubviewRect = CGRectMake(10, 20, 30, 40);
    UIView *subView = [[UIView alloc] initWithFrame:self.originalSubviewRect];
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(20, 70, 300, 300)];

    [superView addSubview:subView];

    _superView = superView;
    _subView = subView;
}

- (void)tearDown {
    _subView = nil;
    _superView = nil;
    _originalSubviewRect = CGRectZero;

    [super tearDown];
}

- (void)testPinToSuperViewEdges_top {
    CGFloat topInset = 17;
    [self.subView pl_expandToSuperViewEdge:NSLayoutAttributeTop withInset:topInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinY(self.superView.bounds) + topInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_top_zeroRectSubviews {
    UIView *zeroRectView = [UIView new];
    CGRect originalFrame = zeroRectView.frame;
    [self.superView addSubview:zeroRectView];

    CGFloat topInset = 17;
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeTop withInset:topInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(zeroRectView.frame), CGRectGetMinY(self.superView.bounds) + topInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(zeroRectView.frame), CGRectGetMaxY(originalFrame) + topInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_expandVertical_zeroRectSubviews {
    UIView *zeroRectView = [UIView new];
    [self.superView addSubview:zeroRectView];

    CGFloat topInset = 17;
    CGFloat bottomInset = 7;
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeTop withInset:topInset];
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeBottom withInset:bottomInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(zeroRectView.frame), CGRectGetMinY(self.superView.bounds) + topInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(zeroRectView.frame), CGRectGetMaxY(self.superView.bounds) - bottomInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_bottom {
    CGFloat bottomInset = 11;
    [self.subView pl_expandToSuperViewEdge:NSLayoutAttributeBottom withInset:bottomInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinY(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.superView.bounds) - bottomInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_left {
    CGFloat leftInset = 13;
    [self.subView pl_expandToSuperViewEdge:NSLayoutAttributeLeft withInset:leftInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(self.originalSubviewRect), FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_left_zeroRectSubviews {
    UIView *zeroRectView = [UIView new];
    CGRect originalFrame = zeroRectView.frame;
    [self.superView addSubview:zeroRectView];

    CGFloat leftInset = 13;
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeLeft withInset:leftInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(zeroRectView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(zeroRectView.frame), CGRectGetMaxX(originalFrame) + leftInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_expandHorizontal_zeroRectSubviews {
    UIView *zeroRectView = [UIView new];
    [self.superView addSubview:zeroRectView];

    CGFloat leftInset = 13;
    CGFloat rightInset = 11;
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeLeft withInset:leftInset];
    [zeroRectView pl_expandToSuperViewEdge:NSLayoutAttributeRight withInset:rightInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(zeroRectView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(zeroRectView.frame), CGRectGetMaxX(self.superView.bounds) - rightInset, FLT_EPSILON);
}

- (void)testPinToSuperViewEdges_right {
    CGFloat rightInset = 3;
    [self.subView pl_expandToSuperViewEdge:NSLayoutAttributeRight withInset:rightInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(self.superView.bounds) - rightInset, FLT_EPSILON);
}

- (void)testAlignToCenterOfView {
    [self.subView pl_alignToCenterOfView:self.superView];
    XCTAssertEqualWithAccuracy(CGRectGetMidX(self.subView.frame), CGRectGetMidX(self.superView.bounds), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMidY(self.subView.frame), CGRectGetMidY(self.superView.bounds), FLT_EPSILON);
}

- (void)testAlignToCenterXOfView {
    [self.subView pl_alignToCenterXOfView:self.superView];
    XCTAssertEqualWithAccuracy(CGRectGetMidX(self.subView.frame), CGRectGetMidX(self.superView.bounds), FLT_EPSILON);
}

- (void)testAlignToCenterYOfView {
    [self.subView pl_alignToCenterYOfView:self.superView];
    XCTAssertEqualWithAccuracy(CGRectGetMidY(self.subView.frame), CGRectGetMidY(self.superView.bounds), FLT_EPSILON);
}

- (void)testAlignToEdgeOfViewWithMargin_top {
    CGFloat topInset = 17;
    [self.subView pl_alignToAttribute:NSLayoutAttributeTop ofView:self.superView withOffset:topInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinY(self.superView.bounds) + topInset, FLT_EPSILON);
}

- (void)testAlignToEdgeOfViewWithMargin_bottom {
    CGFloat bottomInset = 11;
    [self.subView pl_alignToAttribute:NSLayoutAttributeBottom ofView:self.superView withOffset:-bottomInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.superView.bounds) - bottomInset, FLT_EPSILON);
}

- (void)testAlignToEdgeOfViewWithMargin_left {
    CGFloat leftInset = 13;
    [self.subView pl_alignToAttribute:NSLayoutAttributeLeft ofView:self.superView withOffset:leftInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
}

- (void)testAlignToEdgeOfViewWithMargin_right {
    CGFloat rightInset = 3;
    CGRect subView2Rect = self.originalSubviewRect;
    subView2Rect.origin.x = 200;
    UIView *subView2 = [[UIView alloc] initWithFrame:subView2Rect];
    [self.subView pl_alignToAttribute:NSLayoutAttributeRight ofView:subView2 withOffset:-rightInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(subView2.frame) - rightInset, FLT_EPSILON);
}


@end
