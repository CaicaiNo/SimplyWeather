//
//  HeaderView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "DynamicWeatherView.h"
#import "CALayer+MaskLayer.h"
@implementation DynamicWeatherView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.emitterLayer.emitterShape    = kCAEmitterLayerLine;                            // 直线粒子发射器
        self.emitterLayer.emitterMode     = kCAEmitterLayerSurface;                         // ?????
        self.emitterLayer.emitterSize     = frame.size;                                // 发射区域
        self.emitterLayer.emitterPosition = CGPointMake(frame.size.width / 2.f, - 5); // 发射中心点位置
        self.layer.mask = [CALayer createMaskLayerWithSize:CGSizeMake(frame.size.width, frame.size.height)];
    }
    return self;
    
    
}
- (void)configWithType:(EMitterType)type
{
    if (type == EMitterTypeSnow) {
        self.cellImage = [UIImage imageNamed:@"snow"];
        self.birthRate = 20.f;
        self.gravity = 5.f;
        self.cellColor = [UIColor whiteColor];
    
        
    }else{
        self.birthRate = 100.f;
        self.speed     = 10.f;
        self.gravity   = 2000.f;
        self.cellImage = [UIImage imageNamed:@"rain"];
        self.cellColor = [UIColor blackColor];
        self.lifetime  = 1.f;
    }
    self.emitterType = type;
}
- (void)showSnow {
    if (_cellImage == nil) {
        return;
    }
    
    // 创建雪花类型的粒子
    CAEmitterCell *cellflake = [CAEmitterCell emitterCell];
    
    // 粒子的名字
    cellflake.name = @"cell";
    
    // 粒子参数的速度乘数因子
    cellflake.birthRate = (_birthRate > 0 ? _birthRate : 1.f);
    
    // 粒子生命周期
    cellflake.lifetime = (_lifetime > 0 ? _lifetime : 60);
    
    // 粒子速度
    cellflake.velocity = (_speed > 0 ? _speed : 10.f);
    
    // 粒子的速度范围
    cellflake.velocityRange = (_speedRange > 0 ? _speedRange : 10.f);
    
    // 粒子y方向的加速度分量(可以理解为重力)
    cellflake.yAcceleration = (_gravity != 0 ? _gravity : 2.f);
    
    if (self.emitterType == EMitterTypeSnow) {
        // 每个发射的粒子的初始时候随机的角度
        cellflake.emissionRange = 0.5 * M_PI;
        
        // 粒子旋转角度
        cellflake.spinRange = 0.25 * M_PI;
        // 尺寸
        cellflake.scale = 0.5f;
    }else{
        cellflake.emissionRange = 0.f * M_PI;
        cellflake.scale = 0.2;
    }
   
    
    // 获取图片
    cellflake.contents = (id)_cellImage.CGImage;
    
    // 设置雪花形状的粒子的颜色
    cellflake.color = (_cellColor == nil ? [[UIColor whiteColor] CGColor] :_cellColor.CGColor);

    
    
    // 尺寸变化范围
    cellflake.scaleRange = 0.3f;

    // 添加粒子
    self.emitterLayer.emitterCells = @[cellflake];
}

- (void)show {
    [self showSnow];
    
    [UIView animateWithDuration:1.75f animations:^{
        self.alpha = 0.8f;
    }];
}
- (void)hide {
    [UIView animateWithDuration:0.75 animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        
    }];
}

@end
