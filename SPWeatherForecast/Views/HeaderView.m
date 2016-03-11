//
//  HeaderView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/30.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "HeaderView.h"
#import <Masonry.h>
#import <POP.h>
#import "DynamicWeatherView.h"
#import "CALayer+MaskLayer.h"
@interface HeaderView()
/**
 *  显示时间的label
 */
@property (strong, nonatomic) SPLabel *timeLabel;

/**
 *  动画和滑动的UIView
 */
@property (strong, nonatomic) UIView *animationView;
/**
 *  显示天气信息的label
 */
@property (strong, nonatomic) SPLabel *weatherLabel;

@property (strong, nonatomic) DynamicWeatherView *dynamicWeatherView;
@end
@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _animationView = [[UIView alloc]init];
        [self addSubview:_animationView];
        [_animationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right).mas_equalTo(0) ;
            make.size.mas_equalTo(CGSizeMake(Width*0.9, 60));
        }];
        _animationView.backgroundColor = [UIColor clearColor];
        
        
        UIImageView *backImageView = [[UIImageView alloc]init];
        backImageView.image = [UIImage imageNamed:@"headView_image1"];
        [_animationView addSubview:backImageView];
        [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_equalTo(0);
        }];
        _cityNameLabel = [SPLabel CreatHeaderLabelWithText:@"杭州" andFont:Font_STHeitiSC_Light(25)];
        [_animationView addSubview:_cityNameLabel];
        _cityNameLabel.textAlignment = NSTextAlignmentLeft;
        [_cityNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_animationView.mas_centerY).mas_equalTo(0);
            make.left.mas_equalTo(_animationView.mas_left).mas_equalTo(15);
            make.height.mas_equalTo(40);
        }];

        
        
        _timeLabel = [SPLabel CreatHeaderLabelWithText:@"2016.1.7" andFont:Font_STHeitiSC_Light(8)];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_animationView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_animationView.mas_right).mas_equalTo(-20);
            make.bottom.mas_equalTo(_animationView.mas_bottom).mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        [_timeLabel FitSizeAccrodingToScreen];
        _weatherLabel = [SPLabel CreatHeaderLabelWithText:@"晴" andFont:Font_STHeitiSC_Light(25)];
        _weatherLabel.textAlignment = NSTextAlignmentRight;
        [_animationView addSubview:_weatherLabel];
        [_weatherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_animationView.mas_centerY).mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(40);
        }];
        
        _dynamicWeatherView = [[DynamicWeatherView alloc ]initWithFrame:CGRectMake(0, 0, Width*0.9, 60)];
        [_animationView addSubview:_dynamicWeatherView];
//        _snowView.alpha = 0.f;
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, 20, 0);
        self.alpha = 0.f;
        
    }
    return self;
}
-(void)show
{
    [self updateHeaderDataAndEmitterViews];
    
    [UIView animateWithDuration:2 animations:^{
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, -20, 0);
        self.alpha = 1.f;
    }];
}
-(void)hide
{
    [UIView animateWithDuration:2 animations:^{
        self.animationView.transform = CGAffineTransformTranslate(self.animationView.transform, 20, 0);
        self.alpha = 0.f;
    }];
}
- (void)updateHeaderDataAndEmitterViews
{
    _cityNameLabel.text = self.data.cityName;
    _timeLabel.text = self.data.date;
    _weatherLabel.text = self.data.weatherName;
    if ([_weatherLabel.text containsString:@"雪"]) {
        [_dynamicWeatherView configWithType:EMitterTypeSnow];
        [_dynamicWeatherView show];
    }else if([_weatherLabel.text containsString:@"雨"]){
        [_dynamicWeatherView configWithType:EMitterTypeRain];
        [_dynamicWeatherView show];

    }
}
@end
