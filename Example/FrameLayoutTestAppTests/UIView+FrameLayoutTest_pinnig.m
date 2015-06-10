//
//  Created by Pawel Scibek on 09/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLFrameLayout.h"

@interface UIView_FrameLayoutTest_pinnig : XCTestCase
@property(nonatomic, strong, readonly) UIView *superView;
@property(nonatomic, strong, readonly) UIView *subView;
@property(nonatomic, assign, readonly) CGRect originalSubviewRect;
@end

@implementation UIView_FrameLayoutTest_pinnig

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

-(void)testPinToSuperViewEdges_top{
    CGFloat topInset = 17;
    [self.subView pl_pinToSuperViewEdge:NSLayoutAttributeTop withInset:topInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinX(self.superView.bounds) + topInset, FLT_EPSILON);
}

-(void)testPinToSuperViewEdges_bottom{
    CGFloat bottomInset = 11;
    [self.subView pl_pinToSuperViewEdge:NSLayoutAttributeBottom withInset:bottomInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinY(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.superView.bounds) - bottomInset, FLT_EPSILON);
}

-(void)testPinToSuperViewEdges_left{
    CGFloat leftInset = 13;
    [self.subView pl_pinToSuperViewEdge:NSLayoutAttributeLeft withInset:leftInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(self.originalSubviewRect), FLT_EPSILON);
}

-(void)testPinToSuperViewEdges_right{
    CGFloat rightInset = 3;
    [self.subView pl_pinToSuperViewEdge:NSLayoutAttributeRight withInset:rightInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.originalSubviewRect), FLT_EPSILON);
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(self.superView.bounds)-rightInset, FLT_EPSILON);
}

-(void)testAlignToCenterXOfView{
    [self.subView pl_alignToCenterXOfView:self.superView];
    XCTAssertEqualWithAccuracy(CGRectGetMidX(self.subView.frame), CGRectGetMidX(self.superView.bounds), FLT_EPSILON);
}

-(void)testAlignToCenterYOfView{
    [self.subView pl_alignToCenterYOfView:self.superView];
    XCTAssertEqualWithAccuracy(CGRectGetMidY(self.subView.frame), CGRectGetMidY(self.superView.bounds), FLT_EPSILON);
}

-(void)testAlignToEdgeOfViewWithMargin_top{
    CGFloat topInset = 17;
    [self.subView pl_alignTo:NSLayoutAttributeTop ofView:self.superView withMargin:topInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinY(self.subView.frame), CGRectGetMinY(self.superView.bounds) + topInset, FLT_EPSILON);
}

-(void)testAlignToEdgeOfViewWithMargin_bottom{
    CGFloat bottomInset = 11;
    [self.subView pl_alignTo:NSLayoutAttributeBottom ofView:self.superView withMargin:bottomInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxY(self.subView.frame), CGRectGetMaxY(self.superView.bounds) - bottomInset, FLT_EPSILON);
}

-(void)testAlignToEdgeOfViewWithMargin_left{
    CGFloat leftInset = 13;
    [self.subView pl_alignTo:NSLayoutAttributeLeft ofView:self.superView withMargin:leftInset];
    XCTAssertEqualWithAccuracy(CGRectGetMinX(self.subView.frame), CGRectGetMinX(self.superView.bounds) + leftInset, FLT_EPSILON);
}

-(void)testAlignToEdgeOfViewWithMargin_right{
    CGFloat rightInset = 3;
    [self.subView pl_alignTo:NSLayoutAttributeRight ofView:self.superView withMargin:rightInset];
    XCTAssertEqualWithAccuracy(CGRectGetMaxX(self.subView.frame), CGRectGetMaxX(self.superView.bounds) - rightInset, FLT_EPSILON);
}


@end
