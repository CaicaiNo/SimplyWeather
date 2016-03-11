//
//  SPDisplayData.h
//  SPWeatherForecast
//
//  Created by sheng on 16/1/7.
//  Copyright © 2016年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDisplayData : NSObject
@property (nonatomic,copy) NSNumber *weatherID;
@property (nonatomic,copy) NSString *windSpeedStr;
@property (nonatomic,copy) NSString *windDirectionStr;
@property (nonatomic,copy) NSNumber *humidity;
@property (nonatomic,copy) NSNumber *temperture;
@property (nonatomic,copy) NSNumber *maxTemp;
@property (nonatomic,copy) NSNumber *minTemp;
@end
