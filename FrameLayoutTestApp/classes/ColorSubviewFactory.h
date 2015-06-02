//
//  ColorSubviewFactory.h
//  FrameLayoutTestApp
//
//  Created by Pawel Scibek on 02/06/15.
//  Copyright (c) 2015 Polidea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorSubviewFactory : NSObject

+(UIView *)viewWithColor:(UIColor *)viewColor;

+(UIView *)redView;
+(UIView *)greenView;
+(UIView *)yellowView;

@end
