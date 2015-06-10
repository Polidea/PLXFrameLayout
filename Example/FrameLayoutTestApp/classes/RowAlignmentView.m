//
//  RowAlignment.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "RowAlignmentView.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"
#import "UIView+Utilities.h"

static const NSUInteger NumberOfVerticalItems = 6;
static const NSUInteger NumberOfHorizontalItems = 4;

static const CGFloat ItemsVerticalSpacing = 10.0;
static const CGFloat ItemsHorizontalSpacing = 10.0;

@implementation RowAlignmentView {
    NSArray *_verticalItems;
    NSArray *_horizontalItems;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        CGSize itemSize = CGSizeMake(50, 50);

        _verticalItems = [self verticalItemsWithSize:itemSize];
        _horizontalItems = [self horizontalItemsWithSize:itemSize];

        NSArray *allSubviews = [_verticalItems arrayByAddingObjectsFromArray:_horizontalItems];
        for (id viewOrSpace in allSubviews) {
            if ([viewOrSpace isKindOfClass:[UIView class]]) {
                [self addSubview:viewOrSpace];
            }
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self pl_alignViewsVertically:_verticalItems additionallyAligningTo:NSLayoutAttributeCenterX withMargin:0];
    [self pl_alignViewsHorizontally:_horizontalItems additionallyAligningTo:NSLayoutAttributeBottom withMargin:10];
}

- (NSArray *)verticalItemsWithSize:(CGSize)size {
    return [UIView viewsAlignmentArrayWithCapacity:NumberOfVerticalItems
                                    withBuildBlock:^UIView * {
                                        UIView *subview = [ColorSubviewFactory greenView];
                                        subview.pl_size = size;
                                        return subview;
                                    }
                                    defaultSpacing:ItemsVerticalSpacing];
}

- (NSArray *)horizontalItemsWithSize:(CGSize)size {
    return [UIView viewsAlignmentArrayWithCapacity:NumberOfHorizontalItems
                                    withBuildBlock:^UIView * {
                                        UIView *subview = [ColorSubviewFactory yellowView];
                                        subview.pl_size = size;
                                        return subview;
                                    }
                                    defaultSpacing:ItemsHorizontalSpacing];
}

@end
