//
//  SPCity.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCity : UIView

@property (nonatomic, strong) NSString *district;

@property (nonatomic, assign) NSNumber *id;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *city;

@end
