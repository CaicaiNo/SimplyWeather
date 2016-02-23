//
//  SPDisplayData.h
//  SPWeatherForecast
//
//  Created by sheng on 16/1/7.
//  Copyright © 2016年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPDisplayData : NSObject
@property (nonatomic,strong) NSNumber *weatherID;
@property (nonatomic,strong) NSString *windSpeedStr;
@property (nonatomic,strong) NSString *windDirectionStr;
@property (nonatomic,assign) NSNumber *humidity;
@property (nonatomic,strong) NSNumber *temperture;
@property (nonatomic,strong) NSNumber *maxTemp;
@property (nonatomic,strong) NSNumber *minTemp;
@end
