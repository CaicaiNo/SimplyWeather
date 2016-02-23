//
//  UpdatingView.m
//  SPWeatherForecast
//
//  Created by sheng on 16/1/6.
//  Copyright © 2016年 simple. All rights reserved.
//

#import "UpdatingView.h"
#import "ArrowView.h"
#import "WheelView.h"
#import "GCD.h"
@interface UpdatingView ()
@property (nonatomic,strong)ArrowView *arrowView;
@property (nonatomic,strong)WheelView *wheelView;
@end
@implementation UpdatingView

- (instancetype)init
{
    if (self = [super init]) {
    
        _wheelView = [[WheelView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        [self addSubview:_wheelView];
        [_wheelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(200, 200));
        }];
        
        _arrowView = [[ArrowView alloc]init];
        [self addSubview:_arrowView];
        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
        self.alpha = 0.f;
        [self FitSizeAccrodingToScreen];
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}
- (void)show
{
    
    [UIView animateWithDuration:1.5f animations:^{
        self.alpha = 1.f;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.8
                                                      target:self
                                                    selector:@selector(startAnimation)
                                                    userInfo:nil
                                                     repeats:YES];
    }];
}
-(void)hide
{
    [UIView animateWithDuration:2.f animations:^{
        self.alpha = 0.f;
//        [self.timer invalidate];
        self.timer = nil;
        
    } completion:^(BOOL finished) {
        
        [self.arrowView stopAnimation];
        [self.wheelView stopAnimation];
        [self.layer removeAllAnimations];
    }];
}
-(void)startAnimation
{
    dispatch_queue_t queue = dispatch_queue_create("quequeSerial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        [_arrowView startAnimation];
        [_wheelView startAnimation];
    });
    
    

}
-(void)stopAnimation
{
    
}

@end
