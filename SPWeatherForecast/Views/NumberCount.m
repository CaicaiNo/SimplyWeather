//
//  WeatherView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "NumberCount.h"


@implementation NumberCount

- (instancetype)init {
    self = [super init];
    if (self) {
        self.conutAnimation = [POPBasicAnimation animation];
        
    }
    return self;
}

- (void)startAnimation {
    
    // 初始化值
    CGFloat fromeValue = self.fromValue;
    CGFloat toValue    = self.toValue;
    CGFloat duration   = (self.duration <= 0 ? 1.f : self.duration);
    
    // 设定动画
    self.conutAnimation.fromValue      = @(fromeValue);
    self.conutAnimation.toValue        = @(toValue);
    self.conutAnimation.timingFunction = \
        [CAMediaTimingFunction functionWithControlPoints:0.69 :0.11 :0.32 :0.88];
    self.conutAnimation.duration       = duration;

    // 只有执行了代理才会执行计数引擎
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberCount:currentNumber:)]) {
        /* 将计算出来的值通过writeBlock动态给控件设定 */
        self.conutAnimation.property = \
        [POPMutableAnimatableProperty propertyWithName:@"conutAnimation"
                                           initializer:^(POPMutableAnimatableProperty *prop) {
                                               prop.writeBlock      = ^(id obj, const CGFloat values[]) {
                                                   NSNumber *number = @(values[0]);
                                                   [_delegate numberCount:self currentNumber:number];
                                               };
                                           }];
        
        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
}

@end
