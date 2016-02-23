//
//  HeaderView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "CALayer+MaskLayer.h"

@implementation CALayer (MaskLayer)

+ (CALayer *)createMaskLayerWithSize:(CGSize)size maskPNGImage:(UIImage *)image {
    CALayer *layer    = [CALayer layer];
    layer.anchorPoint = CGPointMake(0, 0);                          // 重置锚点
    layer.bounds      = CGRectMake(0, 0, size.width, size.height);  // 设置尺寸
    if (image) {
        layer.contents = (__bridge id)(image.CGImage);
    }

    return layer;
}
+ (CALayer *)createMaskLayerWithSize:(CGSize)size{
//    CALayer *layer    = [CALayer layer];
//    layer.anchorPoint = CGPointMake(0, 0);                          // 重置锚点
//    layer.bounds      = CGRectMake(0, 0, size.width, size.height);  // 设置尺寸
//    layer.backgroundColor = [UIColor blackColor].CGColor;
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.startPoint = CGPointMake(0, 0);
    maskLayer.endPoint = CGPointMake(0, 1);
    maskLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,
                         (__bridge id)[UIColor blackColor].CGColor,
                         (__bridge id)[UIColor blackColor].CGColor,
                         (__bridge id)[UIColor clearColor].CGColor];
    maskLayer.locations =  @[@0,@0.2,@0.8,@1];
    maskLayer.frame = CGRectMake(5,0, size.width-10, size.height);
//    CAGradientLayer *maskLayer1 = [CAGradientLayer layer];
//    maskLayer1.startPoint = CGPointMake(0, 0);
//    maskLayer1.endPoint = CGPointMake(1, 0);
//    maskLayer1.colors = @[(__bridge id)[UIColor clearColor].CGColor,
//                         (__bridge id)[UIColor blackColor].CGColor,
//                          (__bridge id)[UIColor blackColor].CGColor,
//                          (__bridge id)[UIColor clearColor].CGColor];
//    maskLayer1.locations = @[@0,@0.2,@0.8,@1];
//    maskLayer1.frame = CGRectMake(0, size.height*0.2, size.width, size.height*0.6);
//    [layer addSublayer:maskLayer];
//    [layer addSublayer:maskLayer1];
    return maskLayer;
}
@end
