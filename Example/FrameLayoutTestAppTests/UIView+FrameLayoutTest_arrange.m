//
//  Created by Pawel Scibek on 10/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLXFrameLayout.h"
#import "UIView+Utilities.h"

@interface UIView_FrameLayoutTest_arrange : XCTestCase

@property(nonatomic, strong, readonly) UIView *superView;
@property(nonatomic, strong, readonly) NSArray *subViewsArray;
@end

@implementation UIView_FrameLayoutTest_arrange

- (void)setUp {
    [super setUp];

    NSArray *subviewsArray = [UIView viewsAlignmentArrayWithCapacity:3
                                                      withBuildBlock:^UIView * {
                                                          return [[UIView alloc] initWithFrame:CGRectMake(11, 17, 30, 30)];
                                                      }];
    _subViewsArray = subviewsArray;

    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(99, 141, 300, 300)];
    [superView addSubviews:subviewsArray];
    _superView = superView;

}

- (void)tearDown {
    _subViewsArray = nil;
    _superView = nil;

    [super tearDown];
}

- (void)testArrangeSubViewsVerticallyInSuperView_withTopBottomSpaces {
    [self.superView plx_distributeSubviewsVerticallyInSuperView:self.subViewsArray withTopAndBottomMargin:YES];

    CGFloat firstViewTopSpace = CGRectGetMinY([self viewAtIndex:0].frame);
    CGFloat firstAndSecondViewVerticalDistance = CGRectGetMinY([self viewAtIndex:1].frame) - CGRectGetMaxY([self viewAtIndex:0].frame);
    CGFloat secondAndThirdViewVerticalDistance = CGRectGetMinY([self viewAtIndex:2].frame) - CGRectGetMaxY([self viewAtIndex:1].frame);
    CGFloat thirdViewBottomSpace = CGRectGetHeight(self.superView.bounds) - CGRectGetMaxY([self viewAtIndex:2].frame);

    XCTAssertEqualWithAccuracy(firstViewTopSpace, firstAndSecondViewVerticalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(firstAndSecondViewVerticalDistance, secondAndThirdViewVerticalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(secondAndThirdViewVerticalDistance, thirdViewBottomSpace, FLT_EPSILON);
}

- (void)testArrangeSubViewsVerticallyInSuperView {
    [self.superView plx_distributeSubviewsVerticallyInSuperView:self.subViewsArray withTopAndBottomMargin:NO];

    CGFloat firstViewTopSpace = CGRectGetMinY([self viewAtIndex:0].frame) - CGRectGetMinY(self.superView.bounds);
    CGFloat firstAndSecondViewVerticalDistance = CGRectGetMinY([self viewAtIndex:1].frame) - CGRectGetMaxY([self viewAtIndex:0].frame);
    CGFloat secondAndThirdViewVerticalDistance = CGRectGetMinY([self viewAtIndex:2].frame) - CGRectGetMaxY([self viewAtIndex:1].frame);
    CGFloat thirdViewBottomSpace = CGRectGetMaxY(self.superView.bounds) - CGRectGetMaxY([self viewAtIndex:2].frame);

    XCTAssertEqualWithAccuracy(firstViewTopSpace, 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(firstAndSecondViewVerticalDistance, secondAndThirdViewVerticalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(thirdViewBottomSpace, 0, FLT_EPSILON);
}

- (void)testArrangeSubViewsHorizontallyInSuperView_withLeadingAndTralinSpaces {
    [self.superView plx_distributeSubviewsHorizontallyInSuperView:self.subViewsArray withLeftAndRightMargin:YES];

    CGFloat firstViewLeadingSpace = CGRectGetMinX([self viewAtIndex:0].frame);
    CGFloat firstAndSecondViewHorizontalDistance = CGRectGetMinX([self viewAtIndex:1].frame) - CGRectGetMaxX([self viewAtIndex:0].frame);
    CGFloat secondAndThirdViewHorizontalDistance = CGRectGetMinX([self viewAtIndex:2].frame) - CGRectGetMaxX([self viewAtIndex:1].frame);
    CGFloat thirdViewTrailingSpace = CGRectGetWidth(self.superView.bounds) - CGRectGetMaxX([self viewAtIndex:2].frame);

    XCTAssertEqualWithAccuracy(firstViewLeadingSpace, firstAndSecondViewHorizontalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(firstAndSecondViewHorizontalDistance, secondAndThirdViewHorizontalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(secondAndThirdViewHorizontalDistance, thirdViewTrailingSpace, FLT_EPSILON);
}

- (void)testArrangeSubViewsHorizontallyInSuperView {
    [self.superView plx_distributeSubviewsHorizontallyInSuperView:self.subViewsArray withLeftAndRightMargin:NO];

    CGFloat firstViewLeadingSpace = CGRectGetMinX([self viewAtIndex:0].frame);
    CGFloat firstAndSecondViewHorizontalDistance = CGRectGetMinX([self viewAtIndex:1].frame) - CGRectGetMaxX([self viewAtIndex:0].frame);
    CGFloat secondAndThirdViewHorizontalDistance = CGRectGetMinX([self viewAtIndex:2].frame) - CGRectGetMaxX([self viewAtIndex:1].frame);
    CGFloat thirdViewTrailingSpace = CGRectGetWidth(self.superView.bounds) - CGRectGetMaxX([self viewAtIndex:2].frame);

    XCTAssertEqualWithAccuracy(firstViewLeadingSpace, 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(firstAndSecondViewHorizontalDistance, secondAndThirdViewHorizontalDistance, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(thirdViewTrailingSpace, 0, FLT_EPSILON);
}

- (void)testFillSuperViewVerticallyWithViews {
    CGFloat spacing = 10;
    NSMutableArray *viewsOrSpacings = [self.subViewsArray mutableCopy];
    [viewsOrSpacings addObject:@(spacing)];
    [self.superView plx_fillSuperViewVertically:viewsOrSpacings expandableViews:@[[self viewAtIndex:1], [self viewAtIndex:2]]];

    CGFloat allSubviewsHeights = spacing;
    for (UIView *subview in self.subViewsArray) {
        allSubviewsHeights += CGRectGetHeight(subview.bounds);
    }

    XCTAssertEqualWithAccuracy(CGRectGetHeight(self.superView.bounds), allSubviewsHeights, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinY([self viewAtIndex:0].frame), 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY([self viewAtIndex:0].frame), CGRectGetMinY([self viewAtIndex:1].frame), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY([self viewAtIndex:1].frame), CGRectGetMinY([self viewAtIndex:2].frame), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY([self viewAtIndex:2].frame), CGRectGetHeight(self.superView.bounds) - spacing, FLT_EPSILON);
}

- (void)testFillSuperViewHorizontallyWithViews {
    CGFloat spacing = 10.f;
    NSMutableArray *viewsAndSpacings = [self.subViewsArray mutableCopy];
    [viewsAndSpacings insertObject:@(spacing) atIndex:1];
    [self.superView plx_fillSuperViewHorizontally:viewsAndSpacings expandableViews:@[[self viewAtIndex:1], [self viewAtIndex:2]]];

    CGFloat allSubviewsWidths = spacing;
    for (UIView *subview in self.subViewsArray) {
        allSubviewsWidths += CGRectGetWidth(subview.bounds);
    }

    XCTAssertEqualWithAccuracy(CGRectGetWidth(self.superView.bounds), allSubviewsWidths, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinX([self viewAtIndex:0].frame), 0, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX([self viewAtIndex:0].frame), CGRectGetMinX([self viewAtIndex:1].frame) - spacing, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinX([self viewAtIndex:1].frame), CGRectGetMaxX([self viewAtIndex:0].frame) + spacing, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinX([self viewAtIndex:2].frame), CGRectGetMaxX([self viewAtIndex:1].frame), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX([self viewAtIndex:2].frame), CGRectGetWidth(self.superView.bounds), FLT_EPSILON);
}

- (UIView *)viewAtIndex:(NSUInteger)index {
    return self.subViewsArray[index];
}


@end
