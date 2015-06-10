//
//  Created by Pawel Scibek on 09/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UIView+PLFrameLayout.h"

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

-(void)testSetMinY{
    CGRect expectedFrame = self.view.frame;
    CGFloat newMinY = 12;
    expectedFrame.origin.y = newMinY;
    
    [self.view setPl_minY:newMinY];
    
    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

-(void)testMinY{
    CGFloat minY = self.view.pl_minY;
    XCTAssertEqualWithAccuracy(minY, CGRectGetMinY(self.view.frame), FLT_EPSILON);
}

-(void)testSetMaxY{
    CGRect expectedFrame = self.view.frame;
    CGFloat newMaxY = 12;
    CGFloat shift = newMaxY - CGRectGetMaxY(self.view.frame);
    expectedFrame.origin.y += shift;
    
    [self.view setPl_maxY:newMaxY];
    
    XCTAssertTrue(CGRectEqualToRect(self.view.frame, expectedFrame));
}

-(void)testMaxY{
    CGFloat maxY = self.view.pl_maxY;
    XCTAssertEqualWithAccuracy(maxY, CGRectGetMaxY(self.view.frame), FLT_EPSILON);
}

-(void)testSetSize {
    CGSize newSize = CGSizeMake(29, 51);
    self.view.pl_size = newSize;
    XCTAssertTrue(CGSizeEqualToSize(newSize, self.view.frame.size));
}

-(void)testSize {
    CGSize size = self.view.frame.size;
    XCTAssertTrue(CGSizeEqualToSize(size, self.view.pl_size));
}

-(void)testSetWidth{
    CGFloat newWidth = 201;
    self.view.pl_width = newWidth;
    XCTAssertEqualWithAccuracy(newWidth, CGRectGetWidth(self.view.frame), FLT_EPSILON);
}

-(void)testWidth{
    CGFloat width = self.view.pl_width;
    XCTAssertEqualWithAccuracy(width, CGRectGetWidth(self.view.frame), FLT_EPSILON);
}

-(void)testSetHeight{
    CGFloat newHeight = 101;
    self.view.pl_height = newHeight;
    XCTAssertEqualWithAccuracy(newHeight, CGRectGetHeight(self.view.frame), FLT_EPSILON);
}

-(void)testHeight{
    CGFloat height = self.view.pl_height;
    XCTAssertEqualWithAccuracy(height, CGRectGetHeight(self.view.frame), FLT_EPSILON);
}

@end
