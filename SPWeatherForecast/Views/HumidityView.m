//
//  HumidityView.m
//  SPWeatherForecast
//
//  Created by sheng on 15/12/31.
//  Copyright © 2015年 simple. All rights reserved.
//

#import "HumidityView.h"
#import "HumidityCount.h"
#import "AddedFont.h"
#define CENTERX 75
#define CENTERY 75
#define CIRCLEWIDTH 90
#define BUTTONWIDTH 80
@interface HumidityView()<NumberCountDelegate>
//图片视图和作为MaskView的shapelayer层
/**
 *  进度条图
 */
@property (nonatomic,strong) UIImageView *pregressImageView;
/**
 *  点击按钮背景图
 */
@property (nonatomic,strong) UIImageView *clickImageView;
/**
 *  进度条背景图
 */
@property (nonatomic,strong) UIImageView *pregressBackgroundView;
/**
 *  作为进度条的shapelayer层
 */
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
//longpress手势属性和判定BOOL值
@property (nonatomic,strong) UILongPressGestureRecognizer *longPressGR;
@property (nonatomic,assign) BOOL isPressEnd;
@property (nonatomic,assign) BOOL isHideEnd;
/**
 *  动画引擎
 */
@property (nonatomic,strong) HumidityCount *humidityCount;
/**
    变化的label
 */
@property (nonatomic,strong) UILabel *showLabel;
//@property (nonatomic,strong) UICountingLabel *countLabel;

@property (nonatomic,strong) SPLabel *titleLabel;
@end
@implementation HumidityView

-(instancetype)init
{
    if (self = [super init]) {
        _isPressEnd = NO;
        _isHideEnd = NO;
        _pregressBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"oval2"]];
        [self addSubview:_pregressBackgroundView];
        [_pregressBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointMake(0, 0));
            make.size.mas_equalTo(CGSizeMake(CIRCLEWIDTH, CIRCLEWIDTH));
        }];
        _pregressImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Oval 1"]];
        [self addSubview:_pregressImageView];
        [_pregressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointMake(0, 0));
            make.size.mas_equalTo(CGSizeMake(CIRCLEWIDTH, CIRCLEWIDTH));
        }];
        _longPressGR =  [[UILongPressGestureRecognizer alloc]\
                         initWithTarget:self action:@selector(longPress:)];
        _longPressGR.minimumPressDuration = 1.f;
        _longPressGR.numberOfTouchesRequired = 1;
   
        _clickImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"button"]];
        [self addSubview:_clickImageView];
        _clickImageView.userInteractionEnabled = YES;
        [_clickImageView addGestureRecognizer:_longPressGR];
        [_clickImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointMake(0, 0));
            make.size.mas_equalTo(CGSizeMake(BUTTONWIDTH, BUTTONWIDTH));
        }];
        
        //label初始化
        self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(CENTERX-25, CENTERY-15, 60, 40)];
//        self.showLabel.text = @"88";
        self.showLabel.textAlignment = NSTextAlignmentCenter;
        self.showLabel.alpha = 0.f;
//        self.showLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.showLabel];
        
        self.humidityCount          = [HumidityCount new];
        self.humidityCount.delegate = self;
        
        _titleLabel = [SPLabel initTitleLabelByText:@"Humidity"];
        [self addSubview:_titleLabel];
        
        [self setupShapeLayer];
//        [self setupCountLabel];
        self.pregressBackgroundView.alpha = 0.f;
        self.alpha = 0.f;
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
       [self FitSizeAccrodingToScreen];
    }
    return self;
    
}

//numberCount的代理方法
- (void)numberCount:(NumberCount *)numberCount currentSting:(NSAttributedString *)string {
    self.showLabel.attributedText = string;
}
-(void)setupShapeLayer
{
    self.shapeLayer = nil;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CIRCLEWIDTH/2,CIRCLEWIDTH/2) radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 15.f;
    shapeLayer.strokeEnd = 0.f;
    shapeLayer.strokeStart = 0.f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    self.shapeLayer = shapeLayer;
    self.pregressImageView.layer.mask = self.shapeLayer;
    
}
-(void)startAnimation
{
   //定义shapelayer层的动画
    POPSpringAnimation *stringAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    stringAnimation.fromValue = @(0.f);
    stringAnimation.toValue = @([self.humidity floatValue]/100);
    stringAnimation.springBounciness = 6.f;
    stringAnimation.removedOnCompletion = NO;
    stringAnimation.delegate  = self;
    stringAnimation.dynamicsTension = 60.f;
    

    
    [self.shapeLayer pop_addAnimation:stringAnimation forKey:@"strokeEnd"];
//    [self.shapeLayer pop_addAnimation:basicAnimation forKey:@"strokeStart"];
    
    [UIView animateWithDuration:1 animations:^{
        self.pregressBackgroundView.alpha = 1.f;
    }];
    //label的动画
    self.humidityCount.fromValue = 0.f;
    self.humidityCount.toValue = [self.humidity floatValue]?[self.humidity floatValue]:56;
    self.humidityCount.duration = 2.f;
    self.showLabel.transform = CGAffineTransformMake(1.5, 0, 0, 1.5, 0, 0);
    [self.humidityCount startAnimation];
    [UIView animateWithDuration:1.5f animations:^{
        self.showLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        self.showLabel.alpha = 1;
    }];
}
-(void)stopAnimation
{
    [self pop_removeAllAnimations];
}
-(void)hide
{
    self.humidityCount.fromValue = [self.humidity floatValue]?[self.humidity floatValue]:56;
    self.humidityCount.toValue = 0.f;
    self.humidityCount.duration = 2.f;
    [self.humidityCount startAnimation];
    [self animationPartOne];
    [UIView animateWithDuration:2.f animations:^{
        self.showLabel.transform = CGAffineTransformMake(0.5, 0, 0, 0.5, 0, 0);
        self.alpha = 0.f;
        self.transform = CGAffineTransformTranslate(self.transform, -20, 0);
    }];

    
}
-(void)show{
    
    [UIView animateWithDuration:2 animations:^{
        self.transform = CGAffineTransformTranslate(self.transform, 20, 0);
        self.alpha = 1.f;
    }];
    [self startAnimation];
}

-(void)longPress:(UILongPressGestureRecognizer*)gesture
{
    NSLog(@"longpress humidityView");
    if (gesture.state == UIGestureRecognizerStateBegan) {
            [self animationPartOne];
    }
    
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        _isPressEnd = YES;
        if (_isHideEnd == YES) {
            [self startAnimation];
            _isHideEnd = NO;
        }
    }

}
- (void)animationPartOne
{
    
    POPBasicAnimation *hideAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
    hideAnimation.fromValue = @(0.f);
    hideAnimation.toValue = @(1.f);
    hideAnimation.removedOnCompletion = NO;
    hideAnimation.delegate = self;
    hideAnimation.duration = 1.5f;
    [hideAnimation setCompletionBlock:^(POPAnimation * anima, BOOL success) {
        if (success) {
            [CATransaction setDisableActions:YES];
            self.shapeLayer.strokeEnd = 0;
            self.shapeLayer.strokeStart = 0;
            [CATransaction setDisableActions:NO];
//            [self setupShapeLayer];
            
            if (_isPressEnd == YES) {
                [self startAnimation];
                _isPressEnd = NO;
            }else{
                _isHideEnd = YES;
            }
            
            
            
        }
    }];
    POPBasicAnimation *returnAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    returnAnimation.fromValue = @([self.humidity floatValue]/100);
    returnAnimation.toValue = @(1.f);
    returnAnimation.removedOnCompletion = NO;
    returnAnimation.delegate = self;
    returnAnimation.duration = 1.f;
    [self.shapeLayer pop_addAnimation:returnAnimation forKey:nil];
    [UIView animateWithDuration:1 animations:^{
        self.pregressBackgroundView.alpha = 0.f;
    }];
    [self.shapeLayer pop_addAnimation:hideAnimation forKey:@"hideAnimation"];
    self.humidityCount.fromValue = [self.humidity floatValue]?[self.humidity floatValue]:56;
    self.humidityCount.toValue = 0.f;
    self.humidityCount.duration = 2.f;
    [self.humidityCount startAnimation];
    [UIView animateWithDuration:2.f animations:^{
        self.showLabel.transform = CGAffineTransformMake(1.5, 0, 0, 1.5, 0, 0);
    }];

}
@end
