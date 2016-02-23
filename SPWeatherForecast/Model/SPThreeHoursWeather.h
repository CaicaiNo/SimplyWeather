//
//  SPThreeHoursWeather.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPThreeHoursWeather : UIView

@property (nonatomic, assign) NSNumber *sfdate;

@property (nonatomic, assign) NSNumber *efdate;

@property (nonatomic, assign) NSNumber *temp1;

@property (nonatomic, assign) NSNumber *weatherid;

@property (nonatomic, assign) NSNumber *sh;

@property (nonatomic, assign) NSNumber *eh;

@property (nonatomic, assign) NSNumber *date;

@property (nonatomic, strong) NSString *weather;

@property (nonatomic, assign) NSNumber *temp2;

@end
