//
//  SPCurrentWeather.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "SPCurrentWeather.h"

@implementation SPCurrentWeather

-(NSNumber *)getHumidity
{
    NSString *Str = [self.humidity stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSNumber *humidity = [NSNumber numberWithInt:[Str intValue]];
    return humidity;
}

@end
