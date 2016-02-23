//
//  SPDataManager.h
//  SPWeatherForest
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPJuheManager.h"
#import "SPCurrentWeather.h"
#import "SPTodayWeather.h"
#import "SPFutureWeather.h"
#import "SPThreeHoursWeather.h"
#import "SPDisplayData.h"
#import "SPHeaderData.h"

@interface SPDataManager : NSObject

+ (SPCurrentWeather *)parseCurrentWeatherByDictionary:(NSDictionary *)dic;

+ (SPTodayWeather *)parseTodayWeatherByDictionary:(NSDictionary *)dic;

+ (NSArray *)parseFutureWeatherByDictionary:(NSDictionary *)dic;

+ (NSArray *)parseThreeHourWeatherForecastByDictionary:(NSDictionary *)dic;

+ (NSArray *)parseCityListByDictionary:(NSDictionary *)dic;

+ (void)creatCityPlistByDictionary:(NSDictionary *)dic;

+ (SPDisplayData *)getDisplayDataFromDictionary:(NSDictionary *)dic;

+ (SPHeaderData *)getHeaderDataFromDictionary:(NSDictionary *)dic;


@end
