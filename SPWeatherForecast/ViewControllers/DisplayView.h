//
//  DisplayView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPCurrentWeather.h"
#import "SPTodayWeather.h"
#import "SPView.h"
#import "SPThreeHoursWeather.h"
#import "SPDisplayData.h"
@protocol DisplayViewDelegate<NSObject>
- (void)pullUpEventWithData;
- (void)pullDownToRefreshData;
@end
@interface DisplayView : SPView
@property (nonatomic,strong) id<DisplayViewDelegate> delegate;

//@property (nonatomic,strong) SPCurrentWeather *currentWeather;

@property (nonatomic,strong) SPTodayWeather *todayWeather;
//
@property (nonatomic,strong) SPThreeHoursWeather *threeHoursData;


@property (nonatomic,strong) SPDisplayData *data;



@end
