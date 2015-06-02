//
//  ColorSubviewFactory.m
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import "ColorSubviewFactory.h"

@implementation ColorSubviewFactory

+(UIView *)viewWithColor:(UIColor *)viewColor{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [viewColor colorWithAlphaComponent:0.2];
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = viewColor.CGColor;
    
    return view;
}

+(UIView *)redView{
    return [self viewWithColor:[UIColor redColor]];
}

+(UIView *)greenView{
    return [self viewWithColor:[UIColor greenColor]];
}

+(UIView *)yellowView{
    return [self viewWithColor:[UIColor yellowColor]];
}

@end
