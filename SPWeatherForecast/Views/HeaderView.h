//
//  HeaderView.h
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPView.h"
#import "SPHeaderData.h"
@interface HeaderView :SPView
/**
 *  显示城市名label
 */
@property (strong, nonatomic) SPLabel *cityNameLabel;

@property (nonatomic,strong) SPHeaderData *data;

-(void)show;
-(void)hide;
@end
