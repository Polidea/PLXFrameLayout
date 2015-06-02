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

static const NSInteger kNumbeOfVerticalItems     = 7;
static const NSInteger kItemsVerticalSpacing     = 10;

@implementation RowAlignment{
    NSArray *_verticalItems;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSMutableArray *verticalItems = [[NSMutableArray alloc] initWithCapacity:kNumbeOfVerticalItems];
        
        for (int i=0; i < kNumbeOfVerticalItems; i++) {

            UIView *subview = [ColorSubviewFactory greenView];
            subview.size = CGSizeMake(50, 50);
            [self addSubview:subview];
            
            NSArray *subviewWithSpacing = @[@(kItemsVerticalSpacing), subview];
            [verticalItems addObjectsFromArray:subviewWithSpacing];
        }
        
        _verticalItems = verticalItems.copy;
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self alignViewsVertically:_verticalItems additionallyAligningTo:NSLayoutAttributeCenterX withMargin:0];
}


@end
