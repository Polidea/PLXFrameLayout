//
//  Created by Pawel Scibek on 09/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLXFrameLayout.h"

@interface UIView_FrameLayoutTest_properties : XCTestCase
@property(nonatomic, strong, readonly) UIView *view;
@end

@implementation UIView_FrameLayoutTest_properties

- (void)setUp {
    [super setUp];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(123, 456, 789, 159)];
    _view = view;
}

- (void)tearDown {
    _view = nil;
    [super tearDown];
}

- (void)testMinY {
    CGFloat minY = self.view.plx_minY;
    XCTAssertEqualWithAccuracy(minY, CGRectGetMinY(self.view.frame), FLT_EPSILON);
}

- (void)testSetMinY {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMinY = 12;
    expectedFrame.origin.y = newMinY;

    [self.view plx_setMinY:newMinY];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testMidY {
    CGFloat midY = self.view.plx_midY;
    XCTAssertEqualWithAccuracy(midY, CGRectGetMidY(self.view.frame), FLT_EPSILON);
}

- (void)testSetMidY {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMidY = CGRectGetMaxY(self.view.frame);

    expectedFrame.origin.y += (expectedFrame.size.height * 0.5f);

    [self.view plx_setMidY:newMidY];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testSetMaxY {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMaxY = 12;
    CGFloat shift = newMaxY - CGRectGetMaxY(self.view.frame);
    expectedFrame.origin.y += shift;

    [self.view plx_setMaxY:newMaxY];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testMaxY {
    CGFloat maxY = self.view.plx_maxY;
    XCTAssertEqualWithAccuracy(maxY, CGRectGetMaxY(self.view.frame), FLT_EPSILON);
}

- (void)testMinX {
    CGFloat minX = self.view.plx_minX;
    XCTAssertEqualWithAccuracy(minX, CGRectGetMinX(self.view.frame), FLT_EPSILON);
}

- (void)testSetMinX {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMinX = 12;
    expectedFrame.origin.x = newMinX;

    [self.view plx_setMinX:newMinX];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testMidX {
    CGFloat midX = self.view.plx_midX;
    XCTAssertEqualWithAccuracy(midX, CGRectGetMidX(self.view.frame), FLT_EPSILON);
}

- (void)testSetMidX {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMidX = CGRectGetMaxX(self.view.frame);

    expectedFrame.origin.x += (expectedFrame.size.width * 0.5f);

    [self.view plx_setMidX:newMidX];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testMaxX {
    CGFloat maxX = self.view.plx_maxX;
    XCTAssertEqualWithAccuracy(maxX, CGRectGetMaxX(self.view.frame), FLT_EPSILON);
}

- (void)testSetMaxX {
    CGRect expectedFrame = self.view.frame;
    CGFloat newMaxX = 400;
    CGFloat shift = newMaxX - CGRectGetMaxX(self.view.frame);
    expectedFrame.origin.x += shift;

    [self.view plx_setMaxX:newMaxX];

    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

- (void)testSetSize {
    CGSize newSize = CGSizeMake(29, 51);
    self.view.plx_size = newSize;
    XCTAssertTrue(CGSizeEqualToSize(newSize, self.view.frame.size));
}

- (void)testSize {
    CGSize size = self.view.frame.size;
    XCTAssertTrue(CGSizeEqualToSize(size, self.view.plx_size));
}

- (void)testSetWidth {
    CGFloat newWidth = 201;
    self.view.plx_width = newWidth;
    XCTAssertEqualWithAccuracy(newWidth, CGRectGetWidth(self.view.frame), FLT_EPSILON);
}

- (void)testWidth {
    CGFloat width = self.view.plx_width;
    XCTAssertEqualWithAccuracy(width, CGRectGetWidth(self.view.frame), FLT_EPSILON);
}

- (void)testSetHeight {
    CGFloat newHeight = 101;
    self.view.plx_height = newHeight;
    XCTAssertEqualWithAccuracy(newHeight, CGRectGetHeight(self.view.frame), FLT_EPSILON);
}

- (void)testHeight {
    CGFloat height = self.view.plx_height;
    XCTAssertEqualWithAccuracy(height, CGRectGetHeight(self.view.frame), FLT_EPSILON);
}

@end
