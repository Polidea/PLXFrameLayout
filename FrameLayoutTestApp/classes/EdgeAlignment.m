//
//  MainView.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "EdgeAlignment.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"

@implementation EdgeAlignment{
    UIView *_redSquare;
    UIView *_greenSquareTopLeft;
    UIView *_greenSquareTopRight;
    UIView *_greenSquareBottomLeft;
    UIView *_greenSquareBottomRight;

    UIView *_yellowSquareTopMiddle;
    UIView *_yellowSquareBottomMiddle;
    UIView *_yellowSquareLeftMiddle;
    UIView *_yellowSquareRightMiddle;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if(self){
        
        UIView *redSquare = [ColorSubviewFactory redView];
        [self addSubview:redSquare];
        _redSquare = redSquare;
    
        UIView *greenSquareTL = [ColorSubviewFactory greenView];
        [self addSubview:greenSquareTL];
        _greenSquareTopLeft = greenSquareTL;
        
        UIView *greenSquareTR = [ColorSubviewFactory greenView];
        [self addSubview:greenSquareTR];
        _greenSquareTopRight = greenSquareTR;
        
        UIView *greenSquareBL = [ColorSubviewFactory greenView];
        [self addSubview:greenSquareBL];
        _greenSquareBottomLeft = greenSquareBL;
        
        UIView *greenSquareBR = [ColorSubviewFactory greenView];
        [self addSubview:greenSquareBR];
        _greenSquareBottomRight = greenSquareBR;
        
        UIView *yellowSquareTM = [ColorSubviewFactory yellowView];
        [self addSubview:yellowSquareTM];
        _yellowSquareTopMiddle = yellowSquareTM;

        UIView *yellowSquareBM = [ColorSubviewFactory yellowView];
        [self addSubview:yellowSquareBM];
        _yellowSquareBottomMiddle = yellowSquareBM;

        UIView *yellowSquareLM = [ColorSubviewFactory yellowView];
        [self addSubview:yellowSquareLM];
        _yellowSquareLeftMiddle = yellowSquareLM;

        UIView *yellowSquareRM = [ColorSubviewFactory yellowView];
        [self addSubview:yellowSquareRM];
        _yellowSquareRightMiddle = yellowSquareRM;
        
    }
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    _redSquare.size = CGSizeMake(100, 100);
    [_redSquare centerXInSuperView];
    [_redSquare centerYInSuperView];
    
    CGFloat edgeMargin = 10;

    CGSize greensSize = CGSizeMake(70, 70);
    _greenSquareTopLeft.size = greensSize;
    [_greenSquareTopLeft alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_greenSquareTopLeft alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];

    _greenSquareTopRight.size = greensSize;
    [_greenSquareTopRight alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_greenSquareTopRight alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];

    _greenSquareBottomLeft.size = greensSize;
    [_greenSquareBottomLeft alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_greenSquareBottomLeft alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];

    _greenSquareBottomRight.size = greensSize;
    [_greenSquareBottomRight alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_greenSquareBottomRight alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];
    
    CGSize yellowsSize = CGSizeMake(70, 70);
    _yellowSquareTopMiddle.size = yellowsSize;
    [_yellowSquareTopMiddle alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_yellowSquareTopMiddle alignToCenterXOfView:self];
    
    _yellowSquareBottomMiddle.size = yellowsSize;
    [_yellowSquareBottomMiddle alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_yellowSquareBottomMiddle alignToCenterXOfView:self];
    
    _yellowSquareRightMiddle.size = yellowsSize;
    [_yellowSquareRightMiddle alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];
    [_yellowSquareRightMiddle alignToCenterYOfView:self];
    
    _yellowSquareLeftMiddle.size = yellowsSize;
    [_yellowSquareLeftMiddle alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];
    [_yellowSquareLeftMiddle alignToCenterYOfView:self];
}


@end
