

//
//  SPFutureWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPFutureWeather : UIView

@property (nonatomic, copy) NSString *temperature;

@property (nonatomic, copy) NSString *wind;

@property (nonatomic, copy) NSString *week;

@property (nonatomic, copy) NSNumber *date;

@property (nonatomic, copy) NSString *weather;

@property (nonatomic, copy) NSDictionary *weather_id;

- (NSString*)getDateStr;

- (UIImage *)getImage;

@end
