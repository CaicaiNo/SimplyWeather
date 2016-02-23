//
//  SPJuheManager.h
//  SPWeatherForest
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface SPJuheManager : NSObject
@property (nonatomic,strong)NSDictionary *dictionary;
+ (NSDictionary *)getRequestWithCityName:(NSString *)cityName;

+ (NSDictionary *)getRequestWithLocation:(CLLocation *)location;

+ (NSDictionary *)getCityList;

+ (NSDictionary *)getWeatherCategory;

+ (NSDictionary *)getThreeHoursForecastWithCityName:(NSString *)cityName;


@end
