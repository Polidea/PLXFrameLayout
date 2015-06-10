//
//  Created by Pawel Scibek on 08/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "UIView+PLFrameLayout.h"
#import <XCTest/XCTest.h>
#import "UIView+Utilities.h"

@interface UIView_FrameLayoutTest_Allignment : XCTestCase
@property(nonatomic, strong, readonly) NSArray *viewsAndSpacingsArray;
@property(nonatomic, strong, readonly) UIView *superView;
@end

@implementation UIView_FrameLayoutTest_Allignment

- (void)setUp {
    [super setUp];
    
    CGRect superViewFrame = CGRectMake(100, 200, 300, 300);
    UIView *superView = [[UIView alloc] initWithFrame:superViewFrame];
    _superView = superView;
    
    _viewsAndSpacingsArray = [UIView viewsAlignmentArrayWithCapacity:3
                                                      withBuildBlock:^UIView *{
                                                          CGRect subviewRect = CGRectMake(0, 0, 11, 11);
                                                          UIView *subview = [[UIView alloc] initWithFrame:subviewRect];
                                                          return subview;
                                                      } defaultSpacing:19];
    
    for (id subViewOrSpacing in self.viewsAndSpacingsArray) {
        if([subViewOrSpacing isKindOfClass:[UIView class]]){
            [self.superView addSubview:subViewOrSpacing];
        }
    }
}

- (void)tearDown {
    [super tearDown];
    _viewsAndSpacingsArray = nil;
    _superView = nil;
}

#pragma MARK - AlignViewsVertically
- (void)testAlignViewsVertically_verticalDistance {
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray];

    CGRect firstViewFrame = ((UIView *)self.viewsAndSpacingsArray[1]).frame;
    CGRect secondViewFrame = ((UIView *)self.viewsAndSpacingsArray[3]).frame;
    CGRect thirdViewFrame = ((UIView *)self.viewsAndSpacingsArray[5]).frame;
    
    XCTAssertEqualWithAccuracy(CGRectGetMinY(secondViewFrame) - CGRectGetMaxY(firstViewFrame), [self.viewsAndSpacingsArray[2] floatValue], FLT_EPSILON, @"Wrong vertical distance");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(thirdViewFrame) - CGRectGetMaxY(secondViewFrame), [self.viewsAndSpacingsArray[4] floatValue], FLT_EPSILON, @"Wrong vertical distance");
    
    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalCentering {
    CGFloat margin = 0;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterX withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(firstView.center.x, CGRectGetMidX(self.superView.bounds) +margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");
    XCTAssertEqualWithAccuracy(secondView.center.x, CGRectGetMidX(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");
    XCTAssertEqualWithAccuracy(thirdView.center.x, CGRectGetMidX(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect horizontal centering of subview");
    
    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignLeft {
    CGFloat margin = 19;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeLeft withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(firstView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subview left alignment");
    XCTAssertEqualWithAccuracy(secondView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subview left alignment");
    XCTAssertEqualWithAccuracy(thirdView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subview left alignment");
    
    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignRight {
    CGFloat margin = 19;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeRight withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(firstView.frame), CGRectGetMaxX(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subview right alignment");
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(secondView.frame), CGRectGetMaxX(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subview right alignment");
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(thirdView.frame), CGRectGetMaxX(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subview right alignment");
    
    XCTAssertEqualWithAccuracy([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, FLT_EPSILON, @"Wrong total height returned");
}

#pragma MARK - AlignViewsHorizontally
- (void)testAlignViewsHorizontally_horizontalDistance {
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterY withMargin:0];
    
    CGRect firstViewFrame = ((UIView *)self.viewsAndSpacingsArray[1]).frame;
    CGRect secondViewFrame = ((UIView *)self.viewsAndSpacingsArray[3]).frame;
    CGRect thirdViewFrame = ((UIView *)self.viewsAndSpacingsArray[5]).frame;
    
    XCTAssertEqualWithAccuracy(CGRectGetMinX(secondViewFrame) - CGRectGetMaxX(firstViewFrame), [self.viewsAndSpacingsArray[2] floatValue], FLT_EPSILON, @"Incorrect horizontal distance)");
    XCTAssertEqualWithAccuracy(CGRectGetMinX(thirdViewFrame) - CGRectGetMaxX(secondViewFrame), [self.viewsAndSpacingsArray[4] floatValue], FLT_EPSILON, @"Incorrect horizontal distance)");
    
    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignCenter {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterY withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(CGRectGetMidY(firstView.frame), CGRectGetMidY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews vertical center");
    XCTAssertEqualWithAccuracy(CGRectGetMidY(secondView.frame), CGRectGetMidY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews vertical center");
    XCTAssertEqualWithAccuracy(CGRectGetMidY(thirdView.frame), CGRectGetMidY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews vertical center");
    
    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignTop {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeTop withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(CGRectGetMinY(firstView.frame), CGRectGetMinY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews top aling");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(secondView.frame), CGRectGetMinY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews top aling");
    XCTAssertEqualWithAccuracy(CGRectGetMinY(thirdView.frame), CGRectGetMinY(self.superView.bounds)+margin, FLT_EPSILON, @"Incorrect subviews top aling");
    
    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignBottom {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeBottom withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(firstView.frame), CGRectGetMaxY(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subviews bottom aling");
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(secondView.frame), CGRectGetMaxY(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subviews bottom aling");
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(thirdView.frame), CGRectGetMaxY(self.superView.bounds)-margin, FLT_EPSILON, @"Incorrect subviews bottom aling");
    
    XCTAssertEqualWithAccuracy([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, FLT_EPSILON, @"Wrong total width returned");
}


#pragma MARK - Helpers
- (CGFloat)totalHeightOfViewsAndSpacings:(NSArray *)viewsAndSpacing {
    CGFloat totalHeight = 0;
    for(id viewOrSpacing in viewsAndSpacing){
        BOOL isUIViewKind = [viewOrSpacing isKindOfClass:[UIView class]];
        totalHeight += isUIViewKind ? CGRectGetHeight([viewOrSpacing frame]) : [viewOrSpacing floatValue];
    }
    return totalHeight;
}

- (CGFloat)totalWidthOfViewsAndSpacings:(NSArray *)viewsAndSpacing {
    CGFloat totalWidth = 0;
    for(id viewOrSpacing in viewsAndSpacing){
        BOOL isUIViewKind = [viewOrSpacing isKindOfClass:[UIView class]];
        totalWidth += isUIViewKind ? CGRectGetWidth([viewOrSpacing frame]) : [viewOrSpacing floatValue];
    }
    return totalWidth;
}

@end
