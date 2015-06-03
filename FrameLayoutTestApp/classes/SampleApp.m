//
//  SampleApp.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "SampleApp.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"

@implementation SampleApp{
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

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        //containers
        UIView *topContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _topContainer = topContainter;

        UIView *middleContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _middleContainer = middleContainter;
        
        UIView *bottomContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomContainer = bottomContainter;

        [self addSubview:topContainter];
        [self addSubview:middleContainter];
        [self addSubview:bottomContainter];
        
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //containers
    [_topContainer pl_pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_middleContainer pl_pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_bottomContainer pl_pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    
    _topContainer.pl_height = 75;
    _bottomContainer.pl_height = 75;
    
    [self pl_fillSuperViewVerticallyWithViews:@[_topContainer, _middleContainer, _bottomContainer] expandableViews:[NSSet setWithArray:@[_middleContainer]]];
    
    //containers content
    _topLeftView.pl_size = CGSizeMake(50, 50);
    [_topLeftView pl_centerYInSuperView];
    [_topLeftView pl_alignToSuperView:NSLayoutAttributeLeft withMargin:10];
    
    _topRightView.pl_size = CGSizeMake(50, 50);
    [_topRightView pl_centerYInSuperView];
    [_topRightView pl_alignToSuperView:NSLayoutAttributeRight withMargin:10];
    
    [_centerView pl_pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_centerView pl_centerXInSuperView];
    [_centerView pl_pinToSuperViewHorizontalEdgesWithInsets:UIEdgeInsetsZero];

    
    _leftBottomButton.pl_size = CGSizeMake(50, 50);
    _centerBottomButton.pl_size = CGSizeMake(50, 50);
    _rightBottomButton.pl_size = CGSizeMake(50, 50);
    
    [_centerBottomButton pl_centerXInSuperView];
    [_centerBottomButton pl_centerYInSuperView];
    
    [_leftBottomButton pl_centerYInSuperView];
    [_leftBottomButton pl_placeOnLeftOf:_centerBottomButton withMargin:-20];

    [_rightBottomButton pl_centerYInSuperView];
    [_rightBottomButton pl_placeOnRightOf:_centerBottomButton withMargin:20];
}


@end
