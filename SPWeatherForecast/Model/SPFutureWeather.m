//
//  SPFutureWeather.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "SPFutureWeather.h"

@implementation SPFutureWeather

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSString *)getDateStr
{
    NSInteger number = [self.date integerValue];
    NSString *Str = [NSString stringWithFormat:@"%04ld.%02ld.%02ld",number/10000,number%10000/100,number%100];
    return Str;
}
-(UIImage *)getImage
{
    
    NSString *Str = [NSString stringWithFormat:@"icon_%@",self.weather_id[@"fa"]];
    return [UIImage imageNamed:Str];
}
@end
