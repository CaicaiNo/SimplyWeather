

//
//  SPTodayWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTodayWeather : UIView

@property (nonatomic, strong) NSString *temperature;

@property (nonatomic, strong) NSString *dressing_index;

@property (nonatomic, strong) NSString *dressing_advice;

@property (nonatomic, strong) NSString *uv_index;

@property (nonatomic, strong) NSString *comfort_index;

@property (nonatomic, strong) NSString *wind;

@property (nonatomic, strong) NSString *weather;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *date_y;

@property (nonatomic, strong) NSString *week;

@property (nonatomic, strong) NSString *wash_index;

@property (nonatomic, strong) NSString *travel_index;

@property (nonatomic, strong) NSString *exercise_index;

@property (nonatomic, strong) NSString *drying_index;

@property (nonatomic, strong) NSDictionary *weather_id;

- (NSNumber *)getWeatherId;

- (NSNumber *)getMaxTemp;

- (NSNumber *)getMinTemp;
@end
