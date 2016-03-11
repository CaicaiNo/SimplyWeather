//
//  TempCount.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/5.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "TempCount.h"

@implementation TempCount
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberCount:currentSting:)]) {
        /* 将计算出来的值通过writeBlock动态给控件设定 */
        __weak TempCount *weakSelf = self;
        self.conutAnimation.property = \
        [POPMutableAnimatableProperty propertyWithName:@"conutAnimation"
                                           initializer:^(POPMutableAnimatableProperty *prop) {
                                               prop.writeBlock      = ^(id obj, const CGFloat values[]) {
                                                   NSNumber *number = @(values[0]);
                                                   NSAttributedString *attr = [weakSelf accessNumber:number];
                                                   [weakSelf.delegate numberCount:weakSelf currentSting:attr];
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
    NSString *totalStr = [NSString stringWithFormat:@"%@˚C", countStr];
    UIFont *font1       = Font_HeitiSC(50);
    UIFont *font2       = Font_HeitiSC(50);
    NSRange countRange   = [countStr rangeFrom:totalStr]; // %的区域
    NSRange duRange      = [@"˚C" rangeFrom:totalStr];
    return [totalStr createAttributedStringAndConfig:@[
                                                       // 全局设置
                                                       [ConfigAttributedString font:font2
                                                                              range:duRange],
                                                       [ConfigAttributedString font:font1
                                                                              range:countRange],
                                                       
                                                       // 局部设置
//                                                       [ConfigAttributedString attribute:NSTextEffectAttributeName  value:NSTextEffectLetterpressStyle range:duRange],
                                                       [ConfigAttributedString foregroundColor:[UIColor blackColor]
                                                                                         range:countRange],
                                                       [ConfigAttributedString foregroundColor:[UIColor blackColor]
                                                                                         range:duRange]
                                                       
                                                       
                                                       ]];
}

@end
