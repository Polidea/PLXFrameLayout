//
//  SampleApp.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "SampleAppView.h"
#import "UIView+PLXFrameLayout.h"
#import "ColorSubviewFactory.h"

@implementation SampleAppView {
    UIView *_topLeftView;
    UIView *_topRightView;
    UIView *_centerView;
    UIView *_leftBottomButton;
    UIView *_centerBottomButton;
    UIView *_rightBottomButton;

    UIView *_topContainer;
    UIView *_middleContainer;
    UIView *_bottomContainer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //containers
        UIView *topContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _topContainer = topContainer;

        UIView *middleContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _middleContainer = middleContainer;

        UIView *bottomContainer = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomContainer = bottomContainer;

        [self addSubview:topContainer];
        [self addSubview:middleContainer];
        [self addSubview:bottomContainer];

        //container's subviews
        UIView *topLeftView = [ColorSubviewFactory yellowView];
        _topLeftView = topLeftView;

        UIView *topRightView = [ColorSubviewFactory yellowView];
        _topRightView = topRightView;

        [_topContainer addSubview:topLeftView];
        [_topContainer addSubview:topRightView];

        UIView *centerView = [ColorSubviewFactory redView];
        _centerView = centerView;

        [_middleContainer addSubview:centerView];

        UIView *leftBottomButton = [ColorSubviewFactory greenView];
        _leftBottomButton = leftBottomButton;

        UIView *centerBottomButton = [ColorSubviewFactory greenView];
        _centerBottomButton = centerBottomButton;

        UIView *rightBottomButton = [ColorSubviewFactory greenView];
        _rightBottomButton = rightBottomButton;

        [_bottomContainer addSubview:leftBottomButton];
        [_bottomContainer addSubview:centerBottomButton];
        [_bottomContainer addSubview:rightBottomButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //containers
    [_topContainer plx_expandToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_middleContainer plx_expandToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_bottomContainer plx_expandToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];

    _topContainer.plx_height = 75;
    _bottomContainer.plx_height = 75;

    [self plx_fillSuperViewVertically:@[_topContainer, _middleContainer, _bottomContainer]
                      expandableViews:@[_middleContainer]];

    //containers content
    _topLeftView.plx_size = CGSizeMake(50, 50);
    [_topLeftView plx_centerYInSuperView];
    [_topLeftView plx_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:10];

    _topRightView.plx_size = CGSizeMake(50, 50);
    [_topRightView plx_centerYInSuperView];
    [_topRightView plx_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-10];

    [_centerView plx_expandToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_centerView plx_centerXInSuperView];
    [_centerView plx_expandToSuperViewHorizontalEdgesWithInsets:UIEdgeInsetsZero];


    _leftBottomButton.plx_size = CGSizeMake(50, 50);
    _centerBottomButton.plx_size = CGSizeMake(50, 50);
    _rightBottomButton.plx_size = CGSizeMake(50, 50);

    [_centerBottomButton plx_centerXInSuperView];
    [_centerBottomButton plx_centerYInSuperView];

    [_leftBottomButton plx_centerYInSuperView];
    [_leftBottomButton plx_placeOnLeftOf:_centerBottomButton withMargin:20];

    [_rightBottomButton plx_centerYInSuperView];
    [_rightBottomButton plx_placeOnRightOf:_centerBottomButton withMargin:20];
}

@end
