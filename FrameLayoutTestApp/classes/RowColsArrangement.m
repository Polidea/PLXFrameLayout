//
//  RowColsArrangement.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "RowColsArrangement.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"

static const NSInteger kNumbeOfVerticalItems    = 6;
static const NSInteger kNumbeOfHorizontalItems  = 4;

@implementation RowColsArrangement{
    NSArray *_verticalItems;
    NSArray *_horizontalItems;
}

-(instancetype)initWithFrame:(CGRect)frame{
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self pl_arrangeSubViewsHorizontallyInSuperView:_horizontalItems addLeadingAndTrailingSpaces:YES];
    [self pl_arrangeSubViewsVerticallyInSuperView:_verticalItems addTopAndBottomSpaces:YES];
}

-(NSArray *)verticalItemsWithSize:(CGSize)size{
    NSMutableArray *verticalItems = [[NSMutableArray alloc] initWithCapacity:kNumbeOfVerticalItems];
    
    for (int i=0; i < kNumbeOfVerticalItems; i++) {
        
        UIView *subview = [ColorSubviewFactory greenView];
        subview.pl_size = size;
        [verticalItems addObject:subview];
    }
    
    return verticalItems.copy;
}

-(NSArray *)horizontalItemsWithSize:(CGSize)size{
    NSMutableArray *verticalItems = [[NSMutableArray alloc] initWithCapacity:kNumbeOfVerticalItems];
    
    for (int i=0; i < kNumbeOfHorizontalItems; i++) {
        
        UIView *subview = [ColorSubviewFactory yellowView];
        subview.pl_size = size;
        [verticalItems addObject:subview];
    }
    
    return verticalItems.copy;
}

@end
