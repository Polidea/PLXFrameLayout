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

    _redSquare.pl_size = CGSizeMake(100, 100);
    [_redSquare pl_centerXInSuperView];
    [_redSquare pl_centerYInSuperView];

    CGFloat edgeMargin = 10;

    CGSize greensSize = CGSizeMake(70, 70);
    _greenSquareTopLeft.pl_size = greensSize;
    [_greenSquareTopLeft pl_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_greenSquareTopLeft pl_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];

    _greenSquareTopRight.pl_size = greensSize;
    [_greenSquareTopRight pl_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_greenSquareTopRight pl_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];

    _greenSquareBottomLeft.pl_size = greensSize;
    [_greenSquareBottomLeft pl_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_greenSquareBottomLeft pl_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];

    _greenSquareBottomRight.pl_size = greensSize;
    [_greenSquareBottomRight pl_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_greenSquareBottomRight pl_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];

    CGSize yellowsSize = CGSizeMake(70, 70);
    _yellowSquareTopMiddle.pl_size = yellowsSize;
    [_yellowSquareTopMiddle pl_alignToSuperViewAttribute:NSLayoutAttributeTop withOffset:edgeMargin];
    [_yellowSquareTopMiddle pl_alignToCenterXOfView:self];

    _yellowSquareBottomMiddle.pl_size = yellowsSize;
    [_yellowSquareBottomMiddle pl_alignToSuperViewAttribute:NSLayoutAttributeBottom withOffset:-edgeMargin];
    [_yellowSquareBottomMiddle pl_alignToCenterXOfView:self];

    _yellowSquareRightMiddle.pl_size = yellowsSize;
    [_yellowSquareRightMiddle pl_alignToSuperViewAttribute:NSLayoutAttributeRight withOffset:-edgeMargin];
    [_yellowSquareRightMiddle pl_alignToCenterYOfView:self];

    _yellowSquareLeftMiddle.pl_size = yellowsSize;
    [_yellowSquareLeftMiddle pl_alignToSuperViewAttribute:NSLayoutAttributeLeft withOffset:edgeMargin];
    [_yellowSquareLeftMiddle pl_alignToCenterYOfView:self];
}


@end
