//
//  SPTodayWeather.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "SPTodayWeather.h"

@implementation SPTodayWeather

-(NSNumber *)getWeatherId
{
    NSInteger num = [self.weather_id[@"fa"] integerValue];
    NSNumber *number = [NSNumber numberWithInteger:num];
    return number;
}
-(NSNumber *)getMaxTemp
{
    NSArray *tempArray = [self.temperature componentsSeparatedByString:@"~"];
    NSString *mintemp = tempArray.lastObject;
    
    NSString *newMin = [mintemp stringByReplacingOccurrencesOfString:@"℃" withString:@""];
    NSNumber *minNum = [NSNumber numberWithInt:[newMin intValue]];
    return minNum;
}
-(NSNumber *)getMinTemp
{
    NSArray *tempArray = [self.temperature componentsSeparatedByString:@"~"];
    NSString *maxtemp = tempArray.firstObject;
    NSString *newMax = [maxtemp stringByReplacingOccurrencesOfString:@"℃" withString:@""];
    NSNumber *maxNum = [NSNumber numberWithInt:[newMax intValue]];
    return maxNum;
}
@end



