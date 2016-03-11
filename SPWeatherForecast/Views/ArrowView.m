//
//  ArrowView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "ArrowView.h"
#import "YXEasing.h"
#import "GCD.h"
// 将度数转换为弧度
#define   RADIAN(degrees)  ((M_PI * (degrees))/ 180.f)

// 将弧度转换为度数
#define   DEGREES(radian)  ((radian) * 180.f / M_PI)

#define  centerX self.center.x
@interface ArrowView ()
@property (nonatomic,strong) UIImageView *arrowImageView;
@property (nonatomic,strong) UIImageView *backImageView;


@end
@implementation ArrowView

-(instancetype)init
{
    if (self = [super init]) {
        _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
        [self addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        _backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrowOval"]];
        [self addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        self.backgroundColor = [UIColor clearColor];
//        self.layer.cornerRadius = ;
//        self.layer.masksToBounds = YES;
        _arrowImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        
        self.toValue = 0;
        self.fromValue = 0;
        
//        GCDTimer *timer = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
//        [timer event:^{
//            [self show];
//        } timeIntervalWithSecs:NSEC_PER_SEC*2];
        
       
        
    }
    return self;
}
-(void)show
{
    
//    [self startAnimation];
}
-(void)startAnimation
{
    int i = arc4random()%7+1;
    while (i == self.toValue/M_PI_4) {
        i = arc4random()%7+1;
    }
    CGFloat oldValue = self.toValue;
    CGFloat newValue = M_PI_4*i;
    
    self.fromValue = oldValue;
    self.toValue = newValue;
//    CAKeyframeAnimation *arrowAnimation = [CAKeyframeAnimation animation];
//    arrowAnimation.keyPath = @"transform.rotation.z";
//    arrowAnimation.duration = 1.5f;
//    arrowAnimation.values   = [YXEasing calculateFrameFromValue:self.fromValue
//                                                        toValue:self.toValue
//                                                           func:ElasticEaseOut
//                                                     frameCount:60];
//    _arrowImageView.layer.transform = CATransform3DMakeRotation(self.toValue, 0, 0, 1);
//    [_arrowImageView.layer addAnimation:arrowAnimation forKey:nil];
    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    springAnimation.fromValue = [NSNumber numberWithFloat:self.fromValue];
    springAnimation.toValue = [NSNumber numberWithFloat:self.toValue];
    springAnimation.removedOnCompletion = NO;
   
    springAnimation.dynamicsTension = 900.f;
    springAnimation.dynamicsMass = 1.2f;
//    springAnimation.dynamicsFriction = 100;
    [_arrowImageView.layer pop_addAnimation:springAnimation forKey:nil];
   
}
-(void)stopAnimation
{
    [_arrowImageView.layer pop_removeAllAnimations];
}
@end
