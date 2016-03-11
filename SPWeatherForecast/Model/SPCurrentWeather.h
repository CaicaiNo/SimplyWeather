//
//  SPCurrentWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCurrentWeather : UIView


@property (nonatomic, copy) NSString *humidity;

@property (nonatomic, copy) NSString *wind_direction;

@property (nonatomic, copy) NSNumber *temp;

@property (nonatomic, copy) NSString *wind_strength;

@property (nonatomic, copy) NSString *time;

-(NSNumber *)getHumidity;
@end
