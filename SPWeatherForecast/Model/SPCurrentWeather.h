//
//  SPCurrentWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCurrentWeather : UIView


@property (nonatomic, strong) NSString *humidity;

@property (nonatomic, strong) NSString *wind_direction;

@property (nonatomic, strong) NSNumber *temp;

@property (nonatomic, strong) NSString *wind_strength;

@property (nonatomic, strong) NSString *time;

-(NSNumber *)getHumidity;
@end
