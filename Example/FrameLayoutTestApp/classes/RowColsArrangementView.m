//
//  RowColsArrangement.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "RowColsArrangementView.h"
#import "UIView+PLXFrameLayout.h"
#import "ColorSubviewFactory.h"
#import "UIView+Utilities.h"

static const NSInteger NumberOfVerticalItems = 6;
static const NSInteger NumberOfHorizontalItems = 4;

@implementation RowColsArrangementView {
    NSArray *_verticalItems;
    NSArray *_horizontalItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGSize itemSize = CGSizeMake(50, 50);

        _verticalItems = [self verticalItemsWithSize:itemSize];
        _horizontalItems = [self horizontalItemsWithSize:itemSize];

        for (UIView *view in [_verticalItems arrayByAddingObjectsFromArray:_horizontalItems]) {
            [self addSubview:view];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self pl_distributeSubviewsHorizontallyInSuperView:_horizontalItems withLeftAndRightMargin:YES];
    [self pl_distributeSubviewsVerticallyInSuperView:_verticalItems withTopAndBottomMargin:YES];
}

- (NSArray *)verticalItemsWithSize:(CGSize)size {
    return [UIView viewsAlignmentArrayWithCapacity:NumberOfVerticalItems withBuildBlock:^UIView * {
        UIView *subview = [ColorSubviewFactory greenView];
        subview.pl_size = size;
        return subview;
    }];
}

- (NSArray *)horizontalItemsWithSize:(CGSize)size {
    return [UIView viewsAlignmentArrayWithCapacity:NumberOfHorizontalItems withBuildBlock:^UIView * {
        UIView *subview = [ColorSubviewFactory yellowView];
        subview.pl_size = size;
        return subview;
    }];
}

@end
