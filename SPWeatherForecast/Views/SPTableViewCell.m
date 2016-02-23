//
//  SPTableViewCell.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/8.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "SPTableViewCell.h"

@implementation SPTableViewCell

-(void)setFutureData:(SPFutureWeather *)futureData
{
    _futureData = futureData;
    self.temp.text = futureData.temperature;
    self.weather.text = futureData.weather;
    self.date.text = [futureData getDateStr];
    self.weekDay.text = futureData.week;
    [self.weatherIcon  setImage:[futureData getImage]];
    NSLog(@"FUTURECEll数据完成赋值");
    
}
-(void)setHourData:(SPThreeHoursWeather *)hourData
{
    _hourData = hourData;
    self.temp.text = [NSString stringWithFormat:@"%d℃~%d℃",[hourData.temp1 intValue],[hourData.temp2 intValue]];
    self.weather.text = hourData.weather;
    NSInteger number = [hourData.date integerValue];
    self.date.text = [NSString stringWithFormat:@"%04ld.%02ld.%02ld",number/10000,number%10000/100,number%100];
    self.weekDay.text = [NSString stringWithFormat:@"%02ld:00至%02ld:00",(long)[hourData.sh integerValue],(long)[hourData.eh integerValue]];
    [self.weatherIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%02ld",(long)[hourData.weatherid integerValue]]]];
    NSLog(@"HOURCEll数据完成赋值");
}
- (void)awakeFromNib {
    if (iPhone6_plus) {
        self.weather.font = Font_HYQiHei(25);
        self.temp.font = Font_HYQiHei(18);
        self.date.font = Font_HYQiHei(18);
        self.weekDay.font = Font_HYQiHei(18);
    
    }else if (iPhone6){
        self.weather.font = Font_HYQiHei(22);
        self.temp.font = Font_HYQiHei(16);
        self.date.font = Font_HYQiHei(16);
        self.weekDay.font = Font_HYQiHei(16);

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
