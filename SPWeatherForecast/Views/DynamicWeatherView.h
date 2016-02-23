//
//  HeaderView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "EmitterLayerView.h"

@interface DynamicWeatherView : EmitterLayerView

@property (nonatomic, strong) UIImage *cellImage;

@property (nonatomic, assign) CGFloat   lifetime;   // 生命周期
@property (nonatomic, assign) CGFloat   birthRate;  // 出生率
@property (nonatomic, assign) CGFloat   speed;      // 雪花速率
@property (nonatomic, assign) CGFloat   speedRange; // 速率变化范围 [speed - speedRange , speed + speedRange]
@property (nonatomic, assign) CGFloat   gravity;    // 重力
@property (nonatomic, strong) UIColor  *cellColor;  // 雪花颜色
@property (nonatomic, assign) EMitterType emitterType;
- (void)configWithType:(EMitterType )type;
- (void)showSnow;
- (void)show;
- (void)hide;


@end
