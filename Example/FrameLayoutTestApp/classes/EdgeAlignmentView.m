//
//  MainView.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 01/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "EdgeAlignmentView.h"
#import "UIView+PLXFrameLayout.h"
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

    _redSquare.plx_size = CGSizeMake(100, 100);
    [_redSquare plx_centerXInSuperView];
    [_redSquare plx_centerYInSuperView];

    CGFloat edgeMargin = 10;

    CGSize greensSize = CGSizeMake(70, 70);
    _greenSquareTopLeft.plx_size = greensSize;
    [_greenSquareTopLeft plx_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_greenSquareTopLeft plx_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];

    _greenSquareTopRight.plx_size = greensSize;
    [_greenSquareTopRight plx_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_greenSquareTopRight plx_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];

    _greenSquareBottomLeft.plx_size = greensSize;
    [_greenSquareBottomLeft plx_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_greenSquareBottomLeft plx_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];

    _greenSquareBottomRight.plx_size = greensSize;
    [_greenSquareBottomRight plx_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_greenSquareBottomRight plx_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];

    CGSize yellowsSize = CGSizeMake(70, 70);
    _yellowSquareTopMiddle.plx_size = yellowsSize;
    [_yellowSquareTopMiddle plx_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_yellowSquareTopMiddle plx_alignToCenterXOfView:self];

    _yellowSquareBottomMiddle.plx_size = yellowsSize;
    [_yellowSquareBottomMiddle plx_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_yellowSquareBottomMiddle plx_alignToCenterXOfView:self];

    _yellowSquareRightMiddle.plx_size = yellowsSize;
    [_yellowSquareRightMiddle plx_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];
    [_yellowSquareRightMiddle plx_alignToCenterYOfView:self];

    _yellowSquareLeftMiddle.plx_size = yellowsSize;
    [_yellowSquareLeftMiddle plx_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];
    [_yellowSquareLeftMiddle plx_alignToCenterYOfView:self];
}


@end
