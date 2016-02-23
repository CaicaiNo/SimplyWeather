//
//  WeatherView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "HumidityCount.h"
#import "NSString+RichText.h"
#import "AddedFont.h"
#import "SPColors.h"
@implementation HumidityCount

- (void)startAnimation {
    // 初始化值
   
    CGFloat fromeValue = self.fromValue;
    CGFloat toValue    = self.toValue;
    CGFloat duration   = (self.duration <= 0 ? 1.f : self.duration);
    
    // 设定动画
    self.conutAnimation.fromValue      = @(fromeValue);
    self.conutAnimation.toValue        = @(toValue);
    self.conutAnimation.timingFunction = \
    [CAMediaTimingFunction functionWithControlPoints:0.3 :0.3 :0.52 :0.88];
    self.conutAnimation.duration       = duration;
    
    __weak HumidityCount *weakSelf = self;
    // 只有执行了代理才会执行计数引擎
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberCount:currentSting:)]) {
        /* 将计算出来的值通过writeBlock动态给控件设定 */
        self.conutAnimation.property = \
        [POPMutableAnimatableProperty propertyWithName:@"conutAnimation"
                                           initializer:^(POPMutableAnimatableProperty *prop) {
                                           
                                               prop.writeBlock      = ^(id obj, const CGFloat values[]) {
                                                   NSNumber *number = @(values[0]);
                                                   
                                                   NSAttributedString *ats = [weakSelf accessNumber:number];
                                                   [weakSelf.delegate numberCount:weakSelf currentSting:ats];
                                               };
                                           }];
        
        // 添加动画
        [self pop_addAnimation:self.conutAnimation forKey:nil];
    }
}

// 处理富文本
- (NSAttributedString *)accessNumber:(NSNumber *)number {
    
    NSInteger count    = [number integerValue];
    
    NSString *countStr = [NSString stringWithFormat:@"%ld", (long)count];
    NSString *totalStr = [NSString stringWithFormat:@"%@%%", countStr];
    
    UIFont *font1       = [UIFont fontWithName:LATO_LIGHT size:18.f];
    UIFont *font2       = [UIFont fontWithName:LATO_LIGHT size:14.f];
    
    NSRange totalRange   = [totalStr range];              // 全局的区域
    NSRange countRange   = [countStr rangeFrom:totalStr]; // %的区域
    
    return [totalStr createAttributedStringAndConfig:@[
                                                       // 全局设置
                                                       [ConfigAttributedString font:font2
                                                                              range:totalRange],
                                                       [ConfigAttributedString font:font1
                                                                              range:countRange],
                                                       
                                                       // 局部设置
                                                       [ConfigAttributedString foregroundColor:
                                                        UIColorFromRGB(0xC2C2C2)
                                                                                         range:totalRange],
                                                       [ConfigAttributedString foregroundColor:[UIColor blackColor]
                                                                                         range:countRange],


                                                       ]];
}

@end
