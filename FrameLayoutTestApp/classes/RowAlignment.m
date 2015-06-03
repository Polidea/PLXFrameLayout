//
//  RowAlignment.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "RowAlignment.h"
#import "UIView+PLFrameLayout.h"
#import "ColorSubviewFactory.h"

static const NSInteger kNumbeOfVerticalItems    = 6;
static const NSInteger kNumbeOfHorizontalItems  = 4;

static const CGFloat kItemsVerticalSpacing      = 10.0;
static const CGFloat kItemsHorizontalSpacing    = 10.0;

@implementation RowAlignment{
    NSArray *_verticalItems;
    NSArray *_horizontalItems;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGSize itemSize = CGSizeMake(50, 50);
        
        _verticalItems = [self verticalItemsWithSize:itemSize];
        _horizontalItems = [self horizontalItemsWithSize:itemSize];
        
        NSArray *allSubviews = [_verticalItems arrayByAddingObjectsFromArray:_horizontalItems];
        for (id viewOrSpace in allSubviews) {
            if([viewOrSpace isKindOfClass:[UIView class]]){
                [self addSubview:viewOrSpace];
            }
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self pl_alignViewsVertically:_verticalItems additionallyAligningTo:NSLayoutAttributeCenterX withMargin:0];
    [self pl_alignViewsHorizontally:_horizontalItems additionallyAligningTo:NSLayoutAttributeBottom withMargin:10];
}


-(NSArray *)verticalItemsWithSize:(CGSize)size{
    NSMutableArray *verticalItems = [[NSMutableArray alloc] initWithCapacity:kNumbeOfVerticalItems];
    
    for (int i=0; i < kNumbeOfVerticalItems; i++) {
        
        UIView *subview = [ColorSubviewFactory greenView];
        subview.pl_size = size;
        
        NSArray *subviewWithSpacing = @[@(kItemsVerticalSpacing), subview];
        [verticalItems addObjectsFromArray:subviewWithSpacing];
    }
    
    return verticalItems.copy;
}

-(NSArray *)horizontalItemsWithSize:(CGSize)size{
    NSMutableArray *verticalItems = [[NSMutableArray alloc] initWithCapacity:kNumbeOfVerticalItems];
    
    for (int i=0; i < kNumbeOfHorizontalItems; i++) {
        
        UIView *subview = [ColorSubviewFactory yellowView];
        subview.pl_size = size;
        
        NSArray *subviewWithSpacing = @[@(kItemsHorizontalSpacing), subview];
        [verticalItems addObjectsFromArray:subviewWithSpacing];
    }
    
    return verticalItems.copy;
}


@end
