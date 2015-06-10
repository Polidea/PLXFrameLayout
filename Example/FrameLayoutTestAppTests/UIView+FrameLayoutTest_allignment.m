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
    
    XCTAssertEqual(CGRectGetMinY(secondViewFrame) - CGRectGetMaxY(firstViewFrame), [self.viewsAndSpacingsArray[2] floatValue], @"Wrong vertical distance");
    XCTAssertEqual(CGRectGetMinY(thirdViewFrame) - CGRectGetMaxY(secondViewFrame), [self.viewsAndSpacingsArray[4] floatValue], @"Wrong vertical distance");
    
    XCTAssertEqual([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalCentering {
    CGFloat margin = 0;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterX withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(firstView.center.x, CGRectGetMidX(self.superView.bounds) +margin, @"Incorrect horizontal centering of subview");
    XCTAssertEqual(secondView.center.x, CGRectGetMidX(self.superView.bounds)+margin, @"Incorrect horizontal centering of subview");
    XCTAssertEqual(thirdView.center.x, CGRectGetMidX(self.superView.bounds)+margin, @"Incorrect horizontal centering of subview");
    
    XCTAssertEqual([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignLeft {
    CGFloat margin = 19;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeLeft withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(firstView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, @"Incorrect subview left alignment");
    XCTAssertEqual(secondView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, @"Incorrect subview left alignment");
    XCTAssertEqual(thirdView.frame.origin.x, CGRectGetMinX(self.superView.bounds)+margin, @"Incorrect subview left alignment");
    
    XCTAssertEqual([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, @"Wrong total height returned");
}

- (void)testAlignViewsVertically_horizontalAlignRight {
    CGFloat margin = 19;
    
    CGFloat totalHeight = [self.superView pl_alignViewsVertically:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeRight withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(CGRectGetMaxX(firstView.frame), CGRectGetMaxX(self.superView.bounds)-margin, @"Incorrect subview right alignment");
    XCTAssertEqual(CGRectGetMaxX(secondView.frame), CGRectGetMaxX(self.superView.bounds)-margin, @"Incorrect subview right alignment");
    XCTAssertEqual(CGRectGetMaxX(thirdView.frame), CGRectGetMaxX(self.superView.bounds)-margin, @"Incorrect subview right alignment");
    
    XCTAssertEqual([self totalHeightOfViewsAndSpacings:self.viewsAndSpacingsArray], totalHeight, @"Wrong total height returned");
}

#pragma MARK - AlignViewsHorizontally
- (void)testAlignViewsHorizontally_horizontalDistance {
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterY withMargin:0];
    
    CGRect firstViewFrame = ((UIView *)self.viewsAndSpacingsArray[1]).frame;
    CGRect secondViewFrame = ((UIView *)self.viewsAndSpacingsArray[3]).frame;
    CGRect thirdViewFrame = ((UIView *)self.viewsAndSpacingsArray[5]).frame;
    
    XCTAssertEqual(CGRectGetMinX(secondViewFrame) - CGRectGetMaxX(firstViewFrame), [self.viewsAndSpacingsArray[2] floatValue], @"Incorrect horizontal distance)");
    XCTAssertEqual(CGRectGetMinX(thirdViewFrame) - CGRectGetMaxX(secondViewFrame), [self.viewsAndSpacingsArray[4] floatValue], @"Incorrect horizontal distance)");
    
    XCTAssertEqual([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignCenter {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeCenterY withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(CGRectGetMidY(firstView.frame), CGRectGetMidY(self.superView.bounds)+margin, @"Incorrect subviews vertical center");
    XCTAssertEqual(CGRectGetMidY(secondView.frame), CGRectGetMidY(self.superView.bounds)+margin, @"Incorrect subviews vertical center");
    XCTAssertEqual(CGRectGetMidY(thirdView.frame), CGRectGetMidY(self.superView.bounds)+margin, @"Incorrect subviews vertical center");
    
    XCTAssertEqual([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignTop {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeTop withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(CGRectGetMinY(firstView.frame), CGRectGetMinY(self.superView.bounds)+margin, @"Incorrect subviews top aling");
    XCTAssertEqual(CGRectGetMinY(secondView.frame), CGRectGetMinY(self.superView.bounds)+margin, @"Incorrect subviews top aling");
    XCTAssertEqual(CGRectGetMinY(thirdView.frame), CGRectGetMinY(self.superView.bounds)+margin, @"Incorrect subviews top aling");
    
    XCTAssertEqual([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, @"Wrong total width returned");
}

- (void)testAlignViewsHorizontally_verticalAlignBottom {
    CGFloat margin = 19;
    
    CGFloat totalWidth = [self.superView pl_alignViewsHorizontally:self.viewsAndSpacingsArray additionallyAligningTo:NSLayoutAttributeBottom withMargin:margin];
    
    UIView *firstView = (UIView *)self.viewsAndSpacingsArray[1];
    UIView *secondView = (UIView *)self.viewsAndSpacingsArray[3];
    UIView *thirdView = (UIView *)self.viewsAndSpacingsArray[5];
    
    XCTAssertEqual(CGRectGetMaxY(firstView.frame), CGRectGetMaxY(self.superView.bounds)-margin, @"Incorrect subviews bottom aling");
    XCTAssertEqual(CGRectGetMaxY(secondView.frame), CGRectGetMaxY(self.superView.bounds)-margin, @"Incorrect subviews bottom aling");
    XCTAssertEqual(CGRectGetMaxY(thirdView.frame), CGRectGetMaxY(self.superView.bounds)-margin, @"Incorrect subviews bottom aling");
    
    XCTAssertEqual([self totalWidthOfViewsAndSpacings:self.viewsAndSpacingsArray], totalWidth, @"Wrong total width returned");
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
