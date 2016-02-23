//
//  SPDataManager.m
//  SPWeatherForest
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "SPDataManager.h"
#import "SPCity.h"

@implementation SPDataManager

+ (SPCurrentWeather *)parseCurrentWeatherByDictionary:(NSDictionary *)dic
{
    NSDictionary *resultDic = dic[@"result"];
    NSDictionary *skDic = resultDic[@"sk"];
    SPCurrentWeather *currentWeather = [SPCurrentWeather new];
    [currentWeather setValuesForKeysWithDictionary:skDic];
    return currentWeather;
}

+ (SPTodayWeather *)parseTodayWeatherByDictionary:(NSDictionary *)dic
{
    NSDictionary *resultDic = dic[@"result"];
    NSDictionary *todayDic = resultDic[@"today"];
    SPTodayWeather *todayWeather = [SPTodayWeather new];
    [todayWeather setValuesForKeysWithDictionary:todayDic];
    return todayWeather;
}

+ (NSArray *)parseFutureWeatherByDictionary:(NSDictionary *)dic
{
    NSDictionary *resultDic = dic[@"result"];
    NSDictionary *futureDic = resultDic[@"future"];
    NSArray *futureArray = [futureDic allValues];
    NSComparator compare = ^(id obj1, id obj2){
        if ([obj1[@"date"] integerValue] > [obj2[@"date"] integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1[@"date"] integerValue] < [obj2[@"date"] integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    NSArray *sortArray = [futureArray sortedArrayUsingComparator:compare];
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dictionary in sortArray) {
        SPFutureWeather *futureWeather = [SPFutureWeather new];
        [futureWeather setValuesForKeysWithDictionary:dictionary];
        [array addObject:futureWeather];
    }
    return array;
    
}

+ (NSArray *)parseThreeHourWeatherForecastByDictionary:(NSDictionary *)dic
{
    NSArray *resultArray = dic[@"result"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dictionary in resultArray) {
        SPThreeHoursWeather *threeHourWeather = [SPThreeHoursWeather new];
        [threeHourWeather setValuesForKeysWithDictionary:dictionary];
        [array addObject:threeHourWeather];
    }
    return  array;
}

+ (NSArray *)parseCityListByDictionary:(NSDictionary *)dic
{
    static NSArray *cityArray = nil;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *resultArray = dic[@"result"];
        SPCity *city = [SPCity new];
        NSMutableArray *mutableArray  = [NSMutableArray array];
        for (NSDictionary *dictionary in resultArray) {
            [city setValuesForKeysWithDictionary:dictionary];
            [mutableArray addObject:city];
        }
        cityArray = [mutableArray copy];
        
    });
    return cityArray;
}

+ (void)creatCityPlistByDictionary:(NSDictionary *)dic
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *resultArray = dic[@"result"];
        NSString *ducumentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *plistStr = [ducumentsPath stringByAppendingPathComponent:@"city.plist"];
        [resultArray writeToFile:plistStr atomically:YES];

    });
}
+ (SPDisplayData *)getDisplayDataFromDictionary:(NSDictionary *)dic
{
    SPCurrentWeather* currentWeather = [SPDataManager parseCurrentWeatherByDictionary:dic];
    SPTodayWeather* todayWeather = [SPDataManager parseTodayWeatherByDictionary:dic];
//    SPFutureWeather* futureWeatherArray = [SPDataManager parseFutureWeatherByDictionary:dic];
    SPDisplayData* displayData = [[SPDisplayData alloc]init];
    displayData.weatherID = [todayWeather getWeatherId];
    displayData.windSpeedStr = currentWeather.wind_strength;
    displayData.windDirectionStr = currentWeather.wind_direction;
    displayData.humidity = [currentWeather getHumidity];
    displayData.temperture = currentWeather.temp;
    displayData.minTemp = [todayWeather getMinTemp];
    displayData.maxTemp = [todayWeather getMaxTemp];
    return displayData;
}

+(SPHeaderData *)getHeaderDataFromDictionary:(NSDictionary *)dic
{
    SPTodayWeather* todayWeather = [SPDataManager parseTodayWeatherByDictionary:dic];
    SPHeaderData *headerData = [[SPHeaderData alloc]init];
    headerData.cityName = todayWeather.city;
    headerData.date = todayWeather.date_y;
    headerData.weekDay = todayWeather.week;
    headerData.weatherName = todayWeather.weather;
    return headerData;
}


@end
