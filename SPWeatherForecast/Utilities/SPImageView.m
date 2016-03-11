//
//  SPImageView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "SPImageView.h"

@implementation SPImageView
+ (instancetype)initWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    SPImageView *view = [[SPImageView alloc]initWithFrame:frame];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    CGFloat imageW = 50;
    CGFloat imageH = 50;
    CGFloat imageX = (frame.size.width - imageW)/2;
    CGFloat imageY = 0;
    imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imageView];
    view.backgroundColor = [UIColor clearColor];
    view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    return view;
}



@end
