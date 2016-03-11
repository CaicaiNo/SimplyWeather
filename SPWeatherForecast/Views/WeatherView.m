//
//  WeatherView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "WeatherView.h"

@interface WeatherView()
@property (nonatomic,strong) UIImageView *weatherImageView;

@property (nonatomic,strong) UITapGestureRecognizer *tap;

@property (nonatomic,strong) SPLabel *titleLabel;
@end
@implementation WeatherView

-(instancetype)init
{
    if (self = [super init]) {
        
        _weatherImageView = [[UIImageView alloc]init];
        _weatherImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_weatherImageView];
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        _tap.numberOfTapsRequired = 1;
        _tap.numberOfTouchesRequired = 1;
        _weatherImageView.userInteractionEnabled = YES;
        [_weatherImageView addGestureRecognizer:_tap];
        [_weatherImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        
       
        _titleLabel = [SPLabel initTitleLabelByText:@"Weather"];
        [self addSubview:_titleLabel];
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
        self.alpha = 0.f;
        [self FitSizeAccrodingToScreen];
    }
    return self;
}
-(void)startAnimation
{
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.delegate = self;
    scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
    scaleAnimation.springSpeed = 12.f;
    scaleAnimation.springBounciness = 4.f;
    scaleAnimation.dynamicsMass = 3.f;
    scaleAnimation.dynamicsFriction = 15.f;
    scaleAnimation.dynamicsTension = 300.f;
    scaleAnimation.removedOnCompletion = NO;
    [scaleAnimation setCompletionBlock:^(POPAnimation * animation, BOOL success) {
        if (success) {
            POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
            scaleAnimation.delegate = self;
            scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
            scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
                        scaleAnimation.springSpeed = 12.f;
                        scaleAnimation.springBounciness = 4.f;
                        scaleAnimation.dynamicsMass = 2.f;
                        scaleAnimation.dynamicsFriction = 30.f;
                        scaleAnimation.dynamicsTension = 300.f;
            
            [self.weatherImageView.layer pop_addAnimation:scaleAnimation forKey:@"scaleXY_2"];
        }
        
    }];
    
    [self.weatherImageView.layer pop_addAnimation:scaleAnimation forKey:@"scaleXY_1"];
    
}

-(void)stopAnimation
{
    [self.weatherImageView.layer pop_removeAllAnimations];
}
-(void)tap:(UITapGestureRecognizer*)gesture
{
    NSLog(@"clickWeatherIcon");
    [self startAnimation];
    
}
-(void)show{
    
    [_weatherImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%02d",[self.weatherID intValue]?[self.weatherID intValue]:00]]];
    NSLog(@"%02d",[self.weatherID intValue]);
    
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
        self.alpha = 1.f;
    }];
    
}
-(void)hide
{
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
        self.alpha = 0.f;
    }];
}
@end
