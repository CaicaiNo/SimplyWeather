

//
//  SPFutureWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPFutureWeather : UIView

@property (nonatomic, strong) NSString *temperature;

@property (nonatomic, strong) NSString *wind;

@property (nonatomic, strong) NSString *week;

@property (nonatomic, assign) NSNumber *date;

@property (nonatomic, strong) NSString *weather;

@property (nonatomic, strong) NSDictionary *weather_id;

- (NSString*)getDateStr;

- (UIImage *)getImage;

@end
