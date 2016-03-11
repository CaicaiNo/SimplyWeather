//
//  TempColor.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "TempColor.h"

@implementation TempColor
+ (instancetype)ColorWithTempNumber:(CGFloat)interger
{
    if (interger >= 18&&interger <= 24) {
        return (TempColor*)[UIColor colorWithRed:60/255 green:242/255 blue:12/255 alpha:1];
    }else if(interger < 18&&interger>0){
        return (TempColor*)[UIColor colorWithRed:0 green:174/255 blue:239/255 alpha:1];
    }else if(interger <= 0){
         return (TempColor*)[UIColor colorWithRed:15/255 green:0/255 blue:253/255 alpha:1];
    }else if(interger>24&&interger<=28){
         return (TempColor*)[UIColor colorWithRed:223/255 green:64/255 blue:10/255 alpha:1];
    }else if(interger>28&&interger<=32)
    {
         return (TempColor*)[UIColor colorWithRed:240/255 green:0/255 blue:107/255 alpha:1];
    }else{
         return (TempColor*)[UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
}
@end
