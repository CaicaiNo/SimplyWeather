

//
//  SPTodayWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPTodayWeather : UIView

@property (nonatomic, copy) NSString *temperature;

@property (nonatomic, copy) NSString *dressing_index;

@property (nonatomic, copy) NSString *dressing_advice;

@property (nonatomic, copy) NSString *uv_index;

@property (nonatomic, copy) NSString *comfort_index;

@property (nonatomic, copy) NSString *wind;

@property (nonatomic, copy) NSString *weather;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *date_y;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSString *wash_index;

@property (nonatomic, copy) NSString *travel_index;

@property (nonatomic, copy) NSString *exercise_index;

@property (nonatomic, copy) NSString *drying_index;

@property (nonatomic, copy) NSDictionary *weather_id;

- (NSNumber *)getWeatherId;

- (NSNumber *)getMaxTemp;

- (NSNumber *)getMinTemp;
@end
