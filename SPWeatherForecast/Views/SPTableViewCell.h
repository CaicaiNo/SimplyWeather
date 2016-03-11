//
//  SPTableViewCell.h
//  SPWeatherForecast
//
//  Created by sheng on 16/1/8.
//  Copyright © 2016年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPFutureWeather.h"
#import "SPThreeHoursWeather.h"
@interface SPTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weather;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UILabel *weekDay;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (nonatomic,strong) SPFutureWeather *futureData;

@property (nonatomic,strong) SPThreeHoursWeather *hourData;
@end
