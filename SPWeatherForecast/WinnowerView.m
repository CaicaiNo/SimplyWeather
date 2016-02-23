//
//  WinnowerView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/29.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "WinnowerView.h"


// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
#define   DEGREES(radian)  ((radian) * 180.f / M_PI)
@interface WinnowerView()
@property (strong, nonatomic)  UIImageView *rotationView;
@property (strong, nonatomic)  UIImageView *standView;
@property (strong, nonatomic)  UIImageView *ovalView;
/**
 *  Text part
 */
@property (nonatomic,strong) SPLabel *titleLabel;

@property (nonatomic,strong) SPLabel *windSpeed;
@property (nonatomic,strong) SPLabel *windDirection;

@property (nonatomic,strong) NSTimer *timer;
//@property (nonatomic,strong) CADisplayLink *link;
//@property (nonatomic,strong) CALayer *rotationLayer;
@end
@implementation WinnowerView

-(instancetype)init
{
    
    if (self = [super init]) {
    _standView          = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"winnower_stand"]];
    _standView.frame    = CGRectMake(34, 71, 60, 60);
    [self addSubview:_standView];
    _rotationView       = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"windmill_rotationpart"]];
    _rotationView.frame = CGRectMake(31, 45, 60, 60);
        [self addSubview:_rotationView];
    
    _ovalView           = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"oval2"]];
    _ovalView.frame     = CGRectMake(51, 68, 20, 20);
        [self addSubview:_ovalView];
    _titleLabel         = [SPLabel initTitleLabelByText:@"WindSpeed"];
        [self addSubview:_titleLabel];

    _windSpeed          = [SPLabel CreatHeaderLabelWithText:self.windSpeedStr?self.windSpeedStr:@"2级" andFont:Font_STHeitiSC_Light(12)];
//    _windSpeed.backgroundColor = [UIColor redColor];
         [self addSubview:_windSpeed];
         [_windSpeed mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(100);
        make.top.mas_equalTo(40);
    }];
    _windDirection      = [SPLabel CreatHeaderLabelWithText:self.windDirectionStr?self.windDirectionStr:@"东北风" andFont:Font_STHeitiSC_Light(12)];
    [self addSubview:_windDirection];
    [_windDirection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_windSpeed.mas_bottom).mas_equalTo(15);
        make.left.mas_equalTo(_windSpeed);
    }];
    self.transform      = CGAffineTransformTranslate(self.transform, -20, 0);
    self.alpha          = 0.f;
    [self FitSizeAccrodingToScreen];
    }
    return  self;
}

-(void)startAnimation
{
    
    if ([self getWindSpeed] == 0) {
        return;
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
    animation.duration = 2;
    animation.speed = [self getWindSpeed];
    animation.repeatCount = MAXFLOAT;
    self.rotationView.layer.anchorPoint = CGPointMake(0.4494, 0.5862);
    [self.rotationView.layer addAnimation:animation forKey:nil];

    
    
}

-(void)show
{
    _windDirection.text = self.windDirectionStr;
    _windSpeed.text = self.windSpeedStr;
    
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
        self.alpha = 1.f;
        
    }];
    [self startAnimation];
  
}
-(void)hide
{
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
        self.alpha = 0.f;
        
    }];
    [self stopAnimation];

    
}
-(void)stopAnimation
{
    [self.rotationView.layer removeAllAnimations];

}
-(float)getWindSpeed
{
    NSString *string = [self.windSpeedStr stringByReplacingOccurrencesOfString:@"级" withString:@""];
    float i = [string floatValue];
    if (i <= 4&&i >0) {
        return 0.5;
    }else if (i == 0){
        return 0;
    }else if (i >4&&i< 5){
        return 1.5;
    }else if (i >=5&&i<=7){
        return 2.5;
    }else if (i>=8&&i<=10){
        return 5;
    }else{
        return 10;
    }
}
@end
