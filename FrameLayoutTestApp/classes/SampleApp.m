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
        
        UIView *topContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _topContainer = topContainter;

        UIView *middleContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _middleContainer = middleContainter;
        
        UIView *bottomContainter = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomContainer = bottomContainter;

        [self addSubview:topContainter];
        [self addSubview:middleContainter];
        [self addSubview:bottomContainter];
        
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
    
    [_topContainer pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_middleContainer pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    [_bottomContainer pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsZero];
    
    _topContainer.height = 75;
    _bottomContainer.height = 75;
    
    [self fillSuperViewVerticalyWithViews:@[_topContainer, _middleContainer, _bottomContainer] expandableViews:[NSSet setWithArray:@[_middleContainer]]];
    
    _topLeftView.size = CGSizeMake(50, 50);
    [_topLeftView centerYInSuperView];
    [_topLeftView alignToSuperView:NSLayoutAttributeLeft withMargin:10];
    
    _topRightView.size = CGSizeMake(50, 50);
    [_topRightView centerYInSuperView];
    [_topRightView alignToSuperView:NSLayoutAttributeRight withMargin:10];
    
    [_centerView pinToSuperViewVerticalEdgesWithInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [_centerView centerXInSuperView];
    [_centerView pinToSuperViewHorizontalEdgesWithInsets:UIEdgeInsetsZero];

    
    _leftBottomButton.size = CGSizeMake(50, 50);
    _centerBottomButton.size = CGSizeMake(50, 50);
    _rightBottomButton.size = CGSizeMake(50, 50);
    
    [_centerBottomButton centerXInSuperView];
    [_centerBottomButton centerYInSuperView];
    
    [_leftBottomButton centerYInSuperView];
    [_leftBottomButton placeOnLeftOf:_centerBottomButton withMargin:-20];

    [_rightBottomButton centerYInSuperView];
    [_rightBottomButton placeOnRightOf:_centerBottomButton withMargin:20];
    

}


@end
