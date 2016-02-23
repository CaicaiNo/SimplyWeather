//
//  HeaderView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CALayer (MaskLayer)

/**
 *  根据PNG图片创建出用于mask的layer
 *
 *  @param size  mask的尺寸
 *  @param image 用于mask的图片
 *
 *  @return 创建好的mask的layer
 */
+ (CALayer *)createMaskLayerWithSize:(CGSize)size maskPNGImage:(UIImage *)image;

+ (CALayer *)createMaskLayerWithSize:(CGSize)size;
@end
