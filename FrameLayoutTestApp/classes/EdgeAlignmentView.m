//
//  MainView.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "EdgeAlignmentView.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"

@implementation EdgeAlignmentView {
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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {

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

- (void)layoutSubviews {
    [super layoutSubviews];

    _redSquare.pl_size = CGSizeMake(100, 100);
    [_redSquare pl_centerXInSuperView];
    [_redSquare pl_centerYInSuperView];

    CGFloat edgeMargin = 10;

    CGSize greensSize = CGSizeMake(70, 70);
    _greenSquareTopLeft.pl_size = greensSize;
    [_greenSquareTopLeft pl_alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_greenSquareTopLeft pl_alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];

    _greenSquareTopRight.pl_size = greensSize;
    [_greenSquareTopRight pl_alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_greenSquareTopRight pl_alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];

    _greenSquareBottomLeft.pl_size = greensSize;
    [_greenSquareBottomLeft pl_alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_greenSquareBottomLeft pl_alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];

    _greenSquareBottomRight.pl_size = greensSize;
    [_greenSquareBottomRight pl_alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_greenSquareBottomRight pl_alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];

    CGSize yellowsSize = CGSizeMake(70, 70);
    _yellowSquareTopMiddle.pl_size = yellowsSize;
    [_yellowSquareTopMiddle pl_alignToSuperView:NSLayoutAttributeTop withMargin:edgeMargin];
    [_yellowSquareTopMiddle pl_alignToCenterXOfView:self];

    _yellowSquareBottomMiddle.pl_size = yellowsSize;
    [_yellowSquareBottomMiddle pl_alignToSuperView:NSLayoutAttributeBottom withMargin:edgeMargin];
    [_yellowSquareBottomMiddle pl_alignToCenterXOfView:self];

    _yellowSquareRightMiddle.pl_size = yellowsSize;
    [_yellowSquareRightMiddle pl_alignToSuperView:NSLayoutAttributeRight withMargin:edgeMargin];
    [_yellowSquareRightMiddle pl_alignToCenterYOfView:self];

    _yellowSquareLeftMiddle.pl_size = yellowsSize;
    [_yellowSquareLeftMiddle pl_alignToSuperView:NSLayoutAttributeLeft withMargin:edgeMargin];
    [_yellowSquareLeftMiddle pl_alignToCenterYOfView:self];
}


@end
